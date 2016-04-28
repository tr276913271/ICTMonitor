package ict.monitor.web;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ict.monitor.bean.Agent;
import ict.monitor.bean.User;
import ict.monitor.dao.AgentDao;
import ict.monitor.dao.UserDao;
import ict.monitor.service.UserService;

@Controller
public class UserController {
	@Autowired
	private UserService userServiceImp;
	@Autowired
	private UserDao userDao;
	@Autowired
	private AgentDao agentDao;

	@RequestMapping(value = "/user.do")
	@ResponseBody
	public User getUser(HttpServletRequest request, User user) {
		user.setUsername("tian");
		return user;
	}

	@RequestMapping(value = "/signUp.do")
	public String signUp(String username, String password) {
		if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
			return "signUp";
		} else {
			User user = new User(username, password);
			userDao.insert(user);

			return "login";
		}
	}

	@RequestMapping(value = "/signUpAgentID.do")
	public ModelAndView signUpAgentID(HttpServletRequest request) {
		UUID uuid = UUID.randomUUID();
		HttpSession session = request.getSession(true);
		User user = (User) session.getAttribute("userInfo");
		agentDao.insert(new Agent(user.getId(),uuid.toString(),1));
		
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("agentID",uuid.toString());
		return new ModelAndView("signUpAgentID", data);
	}
}
