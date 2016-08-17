package ict.monitor.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ict.monitor.bean.Agent;
import ict.monitor.bean.User;
import ict.monitor.dao.AgentDao;
import ict.monitor.dao.UserDao;

@Controller
public class UserController {
	@Autowired
	private UserDao userDao;
	@Autowired
	private AgentDao agentDao;

	@RequestMapping(value = "/user.do")
	@ResponseBody
	public User getUser(HttpServletRequest request, User user) {
		return user;
	}
	
	@RequestMapping(value = "/index.do")
	public String indexPage(HttpServletRequest request, Model model) {
		User userInfo = (User) request.getSession().getAttribute("userInfo");
		if(userInfo==null){
			return "redirect:login.do";
		}
		ArrayList<Agent> list = agentDao.findAgentIDsByUserID(userInfo.getId());
		model.addAttribute("agents", list);
		return "index";
	}
	
	@RequestMapping(value = "/signUp.do")
	public String signUp(String username, String password) {
		if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
			return "register";
		} else {
			User user = new User(username, password);
			userDao.insert(user);

			return "redirect:login.do";
		}
	}
	
	@RequestMapping(value = "/signUpApp.do")
	public String signUpApp(HttpServletRequest request, Model model) {
		User userInfo = (User) request.getSession().getAttribute("userInfo");
		if(userInfo==null){
			return "redirect:login.do";
		}
		UUID uuid = UUID.randomUUID();
		String uuidstr = uuid.toString();
		uuidstr = uuidstr.substring(0, 18);
		model.addAttribute("uuidstr", uuidstr);
		return "signUpApp";
	}
	
	@RequestMapping(value = "/signUpHost.do")
	public String signUpHost(HttpServletRequest request, Model model) {
		User userInfo = (User) request.getSession().getAttribute("userInfo");
		if(userInfo==null){
			return "redirect:login.do";
		}
		UUID uuid = UUID.randomUUID();
		String uuidstr = uuid.toString();
		uuidstr = uuidstr.substring(0, 18);
		model.addAttribute("uuidstr", uuidstr);
		return "signUpHost";
	}
	
	@RequestMapping(value = "/signUpAgentID.do")
	@ResponseBody
	public String signUpAgentID(HttpServletRequest request, String agentid, int type) {
		HttpSession session = request.getSession(true);
		User user = (User) session.getAttribute("userInfo");
		if(user == null) {
			return "请先登录！";
		}
		try {
			agentDao.insert(new Agent(user.getId(), agentid, type));
		} catch(Exception e) {
			return "失败！";
		}
		return "success";
	}
	
//	@RequestMapping(value = "/signUpAgentID.do")
//	public ModelAndView signUpAgentID(HttpServletRequest request) {
//		UUID uuid = UUID.randomUUID();
//		HttpSession session = request.getSession(true);
//		User user = (User) session.getAttribute("userInfo");
//		agentDao.insert(new Agent(user.getId(),uuid.toString(),1));
//		
//		Map<String, Object> data = new HashMap<String, Object>();
//		data.put("agentID",uuid.toString());
//		return new ModelAndView("signUpAgentID", data);
//	}
}
