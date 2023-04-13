require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true

  def setup
    # Create a test user with a password and username
    # user = User.create(username: "Josh2555", password: "1234")

    headers = { 'Content-Type' => 'application/json' }
    # Send a POST request to the /sessions/create endpoint with a JSON request body
    post '/sessions/create', params: {username: "Josh", password: "1234"}.to_json, headers: headers

    # Check that the response is successful
    assert_response :success

    # Parse the response body as JSON
    response_body = JSON.parse(response.body)

    # Check that the response contains a token
    assert_not_nil response_body['token'], "Response did not contain a token"

    # Store the token for use in subsequent requests
    @token = response_body['token']


    # Use the token to authenticate subsequent requests
    # get "/some/other/endpoint", headers: { 'Authorization' => "Bearer #{token}" }

    # Check that the response to the authenticated request is successful
    assert_response :success
  end

  # end
  test "Create a user" do
    post '/user/create', params: {username: "Test3", password: "1234", account_type: "employee", name: "Test3"}.to_json, headers: {'Content-Type' => 'application/json', 'Authorization' => "Bearer #{@token}"}
    assert_response :success
  end
end
