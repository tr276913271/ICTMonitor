package ict.monitor.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import ict.monitor.bean.Agent;
import ict.monitor.bean.PinpointTarget;
import ict.monitor.bean.User;
import ict.monitor.collection.entity.DevInfoEntity;
import ict.monitor.collection.entity.MetricEntity;
import ict.monitor.context.WebContext;
import ict.monitor.dao.AgentDao;
import ict.monitor.dao.DevInfoDao;
import ict.monitor.dao.MetricDao;

@Controller
public class MonitorController {
	private static Logger logger = LogManager.getLogger(MonitorController.class.getName());
	@Autowired
	private AgentDao agentDao;
	@Autowired
	private DevInfoDao devInfoDao;
	@Autowired
	private MetricDao metricDao;

	@RequestMapping(value = "/monitorList.do")
	public String monitorList(HttpServletRequest request, Model model) {
		User userInfo = (User) request.getSession().getAttribute("userInfo");
		ArrayList<Agent> list = agentDao.findAgentIDsByUserID(userInfo.getId());
		model.addAttribute("agents", list);
		return "monitorList";
	}

	@RequestMapping(value = "/monitorMachineList.do")
	public String monitorMachineList(HttpServletRequest request, Model model, String agentID) {
		ArrayList<Agent> list = agentDao.findAgentByUserIDAndAgentID(1, agentID);
		List<DevInfoEntity> devs = devInfoDao.findDevInfo(agentID);
		model.addAttribute("agents", list);
		model.addAttribute("devs", devs);
		return "monitorMachineList";
	}

	@RequestMapping(value = "/monitor10S.do")
	@ResponseBody
	public List<MetricEntity> monitor10S(String agentID, String devID, int tag) {
		long cycle = 1456128556580L - 10000;
		List<MetricEntity> metrics = metricDao.findMetricCycle(agentID, devID, tag, cycle);
		return metrics;
	}

	// 跳转到websocket界面
	@RequestMapping(value = "/pushData.do")
	public String pushDate(HttpServletRequest request, String agentID, Model model) {
		model.addAttribute("agentID", agentID);
		return "websocket";
	}

	@RequestMapping(value = "/transactionErrorMetadata.do")
	@ResponseBody
	public String transactionErrorMetadata(String application, long from, long to, int limit) {
		String url = WebContext.PINPOINT+"/transactionErrorMetadata.pinpoint?application="+application
				+"&from="+from+"&to="+to+"&limit="+limit;
		return getJsonFromPinpoint(url);
	}

	private String getJsonFromPinpoint(String url) {
		try {
			HttpClient httpclient = new DefaultHttpClient();
			HttpGet httpget = new HttpGet(url);
			HttpResponse response = httpclient.execute(httpget);
			HttpEntity entity = response.getEntity();
			if (entity != null) {
				return EntityUtils.toString(entity);
			}
		} catch (Exception e) {
			logger.warn("读取pinpoint数据异常："+url);
		}
		return "";
	}

}
