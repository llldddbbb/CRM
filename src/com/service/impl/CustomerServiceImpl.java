package com.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.CustomerDao;
import com.dao.CustomerLossDao;
import com.dao.OrderDao;
import com.entity.Customer;
import com.entity.CustomerFw;
import com.entity.CustomerGc;
import com.entity.CustomerGx;
import com.entity.CustomerLoss;
import com.entity.Order;
import com.service.CustomerService;

@Service("customerService")
public class CustomerServiceImpl implements CustomerService{

	@Resource
	private CustomerDao customerDao;
	
	@Resource
	private CustomerLossDao customerLossDao;
	
	
	@Resource
	private OrderDao orderDao;
	
	@Override
	public List<Customer> findCustomerList(Map<String, Object> map) {
		return customerDao.findCustomerList(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return customerDao.getTotal(map);
	}

	@Override
	public int addCustomer(Customer customer) {
		return customerDao.addCustomer(customer);
	}

	@Override
	public int updateCustomer(Customer customer) {
		return customerDao.updateCustomer(customer);
	}

	@Override
	public int deleteCustomer(int id) {
		return customerDao.deleteCustomer(id);
	}

	@Override
	public Customer findCustomerById(Integer id) {
		return customerDao.findCustomerById(id);
	}
	
	@Override
	public void checkCustomerLoss(){
		List<Customer> customerLossList=customerDao.findLossCustomer();//查找流失客户
		for(Customer c:customerLossList){
			CustomerLoss customerLoss=new CustomerLoss();
			customerLoss.setCusNo(c.getKhno());//客户编号
			customerLoss.setCusName(c.getName());//客户姓名
			customerLoss.setCusManager(c.getCusManager());//客户经理 
			customerLoss.setState(c.getState());
			Order order=orderDao.findLastOrderByCusId(c.getId());
			if(order==null){
				customerLoss.setLastOrderTime(null);
			}else{
				customerLoss.setLastOrderTime(order.getOrderDate());//获取最后订单时间
			}
			customerLossDao.addCustomerLoss(customerLoss);
			c.setState(1);//将客户状态设置成流失状态
			customerDao.updateCustomer(c);
		}
	}

	@Override
	public List<CustomerGx> findCustomerGxList(Map<String,Object> map) {
		return customerDao.findCustomerGxList(map);
	}

	@Override
	public Long getTotalCustomerGx(Map<String,Object> map) {
		return customerDao.getTotalCustomerGx(map);
	}

	@Override
	public List<CustomerGc> findCustomerGcList() {
		return customerDao.findCustomerGcList();
	}

	@Override
	public List<CustomerFw> findCustomerFwList() {
		return customerDao.findCustomerFwList();
	}
	

}
