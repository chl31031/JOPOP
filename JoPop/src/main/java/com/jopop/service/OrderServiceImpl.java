package com.jopop.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jopop.mapper.AttachMapper;
import com.jopop.mapper.CartMapper;
import com.jopop.mapper.MemberMapper;
import com.jopop.mapper.OrderMapper;
import com.jopop.mapper.PopMapper;
import com.jopop.model.CartVO;
import com.jopop.model.ImageVO;
import com.jopop.model.MemberVO;
import com.jopop.model.OrderDTO;
import com.jopop.model.OrderItemDTO;
import com.jopop.model.OrderPageItemDTO;

@Service
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private CartMapper cartMapper;
	
	@Autowired
	private PopMapper popMapper;
	
	//주문 정보
	@Override
	public List<OrderPageItemDTO> getPopsInfo(List<OrderPageItemDTO> orders) {
		
		List<OrderPageItemDTO> result = new ArrayList<OrderPageItemDTO>();
		
		OrderPageItemDTO odto =  new OrderPageItemDTO();
		
		for(OrderPageItemDTO ord : orders) {
			
			OrderPageItemDTO orderInfo = orderMapper.getPopsInfo(ord.getpId());
			
			orderInfo.setDiscount(ord.getDiscount());
			orderInfo.setCount(ord.getCount());
			orderInfo.initSaleTotal();
			
			List<ImageVO> imageList = attachMapper.getImageList(orderInfo.getpId());
			
			orderInfo.setImageList(imageList);
			
			System.out.println("주문 정보 : "+orderInfo);
			
			result.add(orderInfo);
		}
		
		return result;
	}

	//주문
	@Override
	@Transactional
	public void order(OrderDTO ord) {
		/* 사용할 데이터 가져오기 */
		
		//회원 정보
		MemberVO member = memberMapper.getMemberInfo(ord.getmId());
		
		System.out.println("member 정보 : "+member);
		
		//주문 정보
		List<OrderItemDTO> ords = new ArrayList<>();
		for(OrderItemDTO oit : ord.getOrders()) {
			OrderItemDTO orderItem = orderMapper.getOrderInfo(oit.getpId());
			//수량 세팅
			orderItem.setCount(oit.getCount());
			//기본 정보 세팅
			orderItem.initSaleTotal();
			//List객체 추가
			ords.add(orderItem);
		}
		/* OrderDTO 세팅 */
		ord.setOrders(ords);
		ord.getOrderPriceInfo();
		
		//orderId만들기 + OrderDTO객체 orderId에 저장
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("_yyyyMMddmm");
		String orderId = member.getmId() + format.format(date);
		ord.setOrderId(orderId);
		
		//mNick을 직접 넣어주기
		ord.setmNick(member.getmNick());
		ord.setmEmail(member.getmEmail());
		
		System.out.println("OrderDTO : "+ord);
		
		//DB넣기
		orderMapper.enrollOrder(ord);
		for(OrderItemDTO oit : ord.getOrders()) {
			oit.setOrderId(orderId);
			orderMapper.enrollOrderItem(oit);
		}
		
		//비용 변동 적용
		int calMoney = member.getMoney();
		calMoney -= ord.getOrderFinalSalePrice();
		member.setMoney(calMoney);                  //변동된 돈 Member객체 적용
		orderMapper.deductMoney(member);            //변동 돈 DB 적용
		
		
		//찜 목록 제거
		for(OrderItemDTO oit: ord.getOrders()) {
			CartVO vo = new CartVO();
			vo.setmId(ord.getmId());
			vo.setpId(oit.getpId());
			
			cartMapper.deleteOrderCart(vo);
		}
	}
	
}
