require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { call_date: @order.call_date, device_id: @order.device_id, issue_id: @order.issue_id, repair_date: @order.repair_date, status: @order.status, store_id: @order.store_id, technician_id: @order.technician_id, work_id: @order.work_id }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { call_date: @order.call_date, device_id: @order.device_id, issue_id: @order.issue_id, repair_date: @order.repair_date, status: @order.status, store_id: @order.store_id, technician_id: @order.technician_id, work_id: @order.work_id }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
