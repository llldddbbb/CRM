package com.quartz;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.service.CustomerService;

//查找流失客户定时任务
@Component
public class FindLossCustomerJob {
	@Resource
	private CustomerService customerService;
	
	@Scheduled(cron="0 0 2 * * ?")//每天凌晨两点执行
	public void work(){
		customerService.checkCustomerLoss();
	}
}
