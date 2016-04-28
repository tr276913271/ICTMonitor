package ict.monitor.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import ict.monitor.bean.User;
import ict.monitor.context.WebContext;
import ict.monitor.dao.UserDao;

@Controller
public class LoginController {
	
	@Autowired
	private UserDao userDao;
	
	@RequestMapping(value = "/login.do")
	public String login (HttpServletRequest request,User user) {
		if(WebContext.DEBUG) {
			User admin = new User();
			admin.setId(0);
			admin.setUsername("tian");
			request.getSession().setAttribute("loged", true);
			request.getSession().setAttribute("userInfo", admin);
		}
		if(user==null){
			return "login";
		} else {
			User findUser = userDao.findUserByUserNameAndPassword(user);
			if(findUser==null){
				return "login";	
			}
			request.getSession().setAttribute("loged", true);
			request.getSession().setAttribute("userInfo", findUser);
			return "main";
		}
	}
}
