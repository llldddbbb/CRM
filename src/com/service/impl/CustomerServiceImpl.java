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
		List<Customer> customerLossList=customerDao.findLossCustomer();//������ʧ�ͻ�
		for(Customer c:customerLossList){
			CustomerLoss customerLoss=new CustomerLoss();
			customerLoss.setCusNo(c.getKhno());//�ͻ����
			customerLoss.setCusName(c.getName());//�ͻ�����
			customerLoss.setCusManager(c.getCusManager());//�ͻ����� 
			customerLoss.setState(c.getState());
			Order order=orderDao.findLastOrderByCusId(c.getId());
			if(order==null){
				customerLoss.setLastOrderTime(null);
			}else{
				customerLoss.setLastOrderTime(order.getOrderDate());//��ȡ��󶩵�ʱ��
			}
			customerLossDao.addCustomerLoss(customerLoss);
			c.setState(1);//���ͻ�״̬���ó���ʧ״̬
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
