package com.wisenut.act.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wisenut.act.mapper.ActMapper;
import com.wisenut.act.mapper.StudyMapper;
import com.wisenut.act.vo.ActVo;
import com.wisenut.server.vo.ServerVo;
import com.wisenut.util.cfHttp.HttpService;
import com.wisenut.util.cfUtil.CfApiUtil;
import com.wisenut.util.cfUtil.CfApiVo;
import com.wisenut.util.classificator.ClientService;
import com.wisenut.util.classificator.ClientVo;
import com.wisenut.util.classificator.pojo.ClassifiedLabelPojo;

@Service
public class ActService {
	
	private Logger logger = Logger.getLogger(ActService.class);
	
	@Autowired
	private ActMapper actMapper;
	
	
	@Autowired
	private StudyMapper stdMapper;
	
	
	
	@Autowired
	private HttpService httpService;
	

	/**
	 * 자동분류 엔진과 통신
	 * @param clVo
	 * @return
	 */
	public Map<String, Object> getActRs(ClientVo clVo) {

		List<ClassifiedLabelPojo> classifiedlabels = ClientService.act(clVo);
		Map<String,Object> map 	= new HashMap<String,Object>();
		List<ActVo> list 	= new ArrayList<>();
		ActVo vo 	= null;
		String analRs = "";
		

		for (int i = 0; i < classifiedlabels.size(); i++) {

			vo = new ActVo();
			ClassifiedLabelPojo pojo = classifiedlabels.get(i);
			
			if (i == 0) analRs = pojo.getLabel();

			vo.setAnalLabel(pojo.getLabel());
			vo.setAnalConfidence(String.valueOf(pojo.getConfidence()));
			list.add(vo);
		}

		map.put("analRs", analRs);
		map.put("list", list);
		map.put("sentence", clVo.getSentence());
		
		return map;
	}


	/**
	 * 
	 * @param actVo
	 * @return
	 * @throws Exception
	 */
	public int getTotalActList(ActVo actVo) throws Exception{
		return actMapper.getTotalActList(actVo);
	}


	/**
	 * 
	 * @param actVo
	 * @return
	 * @throws Exception
	 */
	public List<ActVo> getActList(ActVo actVo) throws Exception{
		return actMapper.getActList(actVo);
	}


	/**
	 * 
	 * @param cf_id
	 * @return
	 * @throws Exception
	 */
	public ActVo getDetail(String cf_id) throws Exception{
		return actMapper.getDetail(cf_id);
		
	}


	/**
	 * 
	 * @param clIp, clPort, content 
	 * @return Map
	 * @throws Exception
	 */
	public Map<String, Object> getCfText(String clIp, String clPort, String content, String cfsv_id, String anal_threshold) throws Exception{
		
		String collection		= "singo";
		
		//CF 엔진 호출
		CfApiVo runAnalyCf = CfApiUtil.runAnalyCf(collection, content, String.valueOf(clIp.toString().trim()), String.valueOf(clPort.toString().trim()), Double.valueOf(anal_threshold));
		
		logger.debug("#### runAnalyCf :" + runAnalyCf);
		runAnalyCf.setContent(String.valueOf(content));
		runAnalyCf.setAnswer(String.valueOf(runAnalyCf.getResultAnal( )));
		
		Map<String,Object> map 	= new HashMap<String,Object>();
		map.put("analRs", String.valueOf(runAnalyCf.getResultAnal( )));
		map.put("list", runAnalyCf.getResultList());
		
		List<Map<String, String>> cateList = stdMapper.getCategoriesBySvId(cfsv_id);
		
		map.put("listCt", cateList);

		return map;
		
	}


	public ServerVo getServer(String cfsv_id) throws Exception{
		
		return actMapper.getServer(cfsv_id);
	}
}
