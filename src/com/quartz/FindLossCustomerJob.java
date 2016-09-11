package com.quartz;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.service.CustomerService;

//������ʧ�ͻ���ʱ����
@Component
public class FindLossCustomerJob {
	@Resource
	private CustomerService customerService;
	
	@Scheduled(cron="0 0 2 * * ?")//ÿ���賿����ִ��
	public void work(){
		customerService.checkCustomerLoss();
	}
}
