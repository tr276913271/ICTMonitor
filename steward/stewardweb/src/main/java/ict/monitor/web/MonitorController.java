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

//http://192.168.25.128:28080/applications.pinpoint
//[{"applicationName":"TESTAPP","serviceType":"TOMCAT","code":1010}]
//http://192.168.25.128:28080/#/main/TESTAPP@TOMCAT/1h/2016-03-16-20-41-25
@Controller
public class MonitorController {
	@Autowired
	private AgentDao agentDao;
	@Autowired
	private DevInfoDao devInfoDao;
	@Autowired
	private MetricDao metricDao;
	
	@RequestMapping(value = "/monitorList.do")
	public String monitorList(HttpServletRequest request, Model model) {
		User userInfo = (User) request.getSession().getAttribute("userInfo");

		ArrayList<Agent> list = agentDao.findAgentIDsByUserID(1);
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

	@RequestMapping(value = "/monitorServerList.do")
	public ModelAndView  monitorServerList(HttpServletResponse response, String agentID, Model model) {
		ModelAndView view = new ModelAndView();
        view.setViewName("redirect:"+pinpointMonitor(agentID));
        return view;
	}

	@RequestMapping(value = "/monitor10S.do")
	@ResponseBody
	public List<MetricEntity> monitor10S(String agentID, String devID, int tag) {
		long cycle = 1456128556580L - 10000;
		List<MetricEntity> metrics = metricDao.findMetricCycle(agentID, devID, tag, cycle);
		return metrics;
	}

	@RequestMapping(value = "/pinpointMonitor.do")
	@ResponseBody
	public String pinpointMonitor(String agentID) {
		try {
			HttpClient httpclient = new DefaultHttpClient();
			HttpGet httpget = new HttpGet(WebContext.PINPOINT);
			HttpResponse response = httpclient.execute(httpget);
			HttpEntity entity = response.getEntity();
			if (entity != null) {
				ObjectMapper mapper = new ObjectMapper();
				List<PinpointTarget> userList = mapper.readValue(EntityUtils.toString(entity), new TypeReference<List<PinpointTarget>>() {
				});
				for (PinpointTarget pinpointTarget : userList) {
					agentID = "TESTAPP";
					if (pinpointTarget.getApplicationName().equals(agentID)) {
						SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
						return "http://192.168.25.128:28080/#/main/" + agentID + "@" + pinpointTarget.getServiceType() + "/20m/" + format.format(new Date());
					}
				}
			}
		} catch (Exception e) {
		}
		return "error";
	}
	//跳转到websocket界面
	@RequestMapping(value = "/pushDate.do")
	public String pushDate(HttpServletRequest request,String agentID,Model model) {
		model.addAttribute("agentID", agentID);
		return "websocket";
	}
}
