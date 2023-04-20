# frozen_string_literal: true



require 'minitest/mock'


class ReimbursementControllerTest < ActionDispatch::IntegrationTest


  def setup
    # Create a test user with a password and username
    # user = User.create(username: "Josh2555", password: "1234")

    headers = { 'Content-Type' => 'application/json' }
    # Send a POST request to the /sessions/create endpoint with a JSON request body
    post '/sessions/create', params: {username: 'Josh', password: '1234'}.to_json, headers: headers

    # Check that the response is successful
    assert_response :success

    # Parse the response body as JSON
    response_body = JSON.parse(response.body)

    # Check that the response contains a token
    assert_not_nil response_body['token'], 'Response did not contain a token'

    # Store the token for use in subsequent requests
    @token = response_body['token']


    # Use the token to authenticate subsequent requests
    # get "/some/other/endpoint", headers: { 'Authorization' => "Bearer #{token}" }

    # Check that the response to the authenticated request is successful
    assert_response :success
  end
  FactoryBot.define do
    factory :reimbursement do
      :id
      :description
      :amount
      :status
      :created_at
      :updated_at
      :user_id
      # other attributes as needed
    end
  end

  test 'GET /reimbursement/all returns all reimbursements' do
    reimbursement1 = create(:reimbursement, id: 1, description: 'test 1', amount: Faker::Number.number, status: 'pending', created_at: Faker::Date, updated_at: Faker::Date, user_id: 1)
    reimbursement2 = create(:reimbursement, id: 2, description: 'test 2', amount: Faker::Number.number, status: 'pending', created_at: Faker::Date, updated_at: Faker::Date, user_id: 1)

    reimbursementMock = MiniTest::Mock.new
    reimbursementMock.expect :all, [reimbursement1, reimbursement2]
    original_all_method = Reimbursement.method(:all)
    Reimbursement.define_singleton_method(:all) do |*args|
      reimbursementMock.all(*args)
    end
    # Make a GET request to the index action
    get '/reimbursement/index', headers: { 'Authorization' => "Bearer #{@token}" }

    # Assert that the response contains the reimbursement names
    assert_response :success
    assert_includes response.body, 'test 1'
    assert_includes response.body, 'test 2'

    # Verify that the mock was called
    reimbursementMock.verify

    # Restore the original implementation of `all`
    Reimbursement.define_singleton_method(:all, &original_all_method)

    # Reimbursement.stub :all, [reimbursement1, reimbursement2] do
    #   get "/reimbursement/index"
    #   assert_response :success
    #   assert_equal 2, JSON.parse(response.body).length
    #   assert_includes response.body, reimbursement1.description
    # end
  end

  # def test_get_reimbursements
  #   mock_db = Minitest::Mock.new
  #   mock_db.expect :query, [[3,"Test1","200","pending","2023-04-03T16:02:24.246Z","2023-04-03T16:02:24.246Z",6],[4,"Test2","400","pending","2023-04-03T16:02:24.246Z","2023-04-03T16:02:24.246Z",6],[5,"Test3","600","approved","2023-04-03T16:02:24.246Z","2023-04-03T16:02:24.246Z",6]], ["Select id, description, amount, created_at, updated_at, user_id from reimbursement"]
  #
  #   Reimbursement.stub(:connection, mock_db) do
  #
  #     reimbursement = Reimbursement.all
  #
  #     assert_mock mock_db
  #
  #     assert_equal 3, reimbursement.length
  #   end
  # end

  test 'POST /reimbursement/create creates a reimbursement and returns a message' do
    post '/reimbursement/create', params: {description: 'test', amount: '100', status: 'pending'}.to_json, headers: {'Content-Type' => 'application/json', 'Authorization' => "Bearer #{@token}"}
    assert_response :success
  end




  # test "PUT /reimbursement/update updates a reimbursement and returns a message" do
  #   put '/reimbursement/update/1', params: {description: "test", status: "approved"}.to_json, headers: {'Content-Type' => 'application/json', 'Authorization' => "Bearer #{@token}"}
  #   assert_response :success
  #   # post '/reimbursement/update'
  # end
end
