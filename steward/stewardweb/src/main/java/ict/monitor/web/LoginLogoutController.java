package ict.monitor.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import ict.monitor.bean.User;
import ict.monitor.dao.UserDao;

@Controller
public class LoginLogoutController {
	
	@Autowired
	private UserDao userDao;
	
	@RequestMapping(value = "/login.do")
	public String login (HttpServletRequest request,User user) {
		if(user==null){
			return "login";
		} else {
			User findUser = userDao.findUserByUserNameAndPassword(user);
			if(findUser==null){
				return "login";	
			}
			request.getSession().setAttribute("loged", true);
			request.getSession().setAttribute("userInfo", findUser);
			return "redirect:index.do";
		}
	}
	
	@RequestMapping(value = "/logout.do")
	public String logout (HttpServletRequest request) {
		User findUser = (User) request.getSession().getAttribute("userInfo");
		if(findUser!=null){
			request.getSession().removeAttribute("loged");
			request.getSession().removeAttribute("userInfo");
		}
		return "redirect:login.do";
	}
}
