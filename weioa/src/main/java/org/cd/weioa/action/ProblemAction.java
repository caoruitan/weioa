package org.cd.weioa.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.cd.weioa.entity.Problem;
import org.cd.weioa.entity.ProblemStatus;
import org.cd.weioa.service.ProblemService;
import org.cd.weioa.weinxin.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping( "problem/" )
public class ProblemAction {

    @Autowired
    private ProblemService problemService;

    @RequestMapping("myProblems")
    public String myProblems(HttpServletRequest request) {
        UserInfo userInfo = (UserInfo) request.getSession(true).getAttribute("userInfo");
        List<Problem> problems = this.problemService.getProblemListByCreator(userInfo.getUserId());
        request.setAttribute("problems", problems);
        request.setAttribute("statusNames", ProblemStatus.statusNames);
        return "problem/myProblems";
    }
    
    @RequestMapping("toSubmitProblem")
    public String toSubmitProblem() {
        return "problem/submitProblem";
    }
    
    @RequestMapping("submitProblem")
    public String submitProblem(HttpServletRequest request) {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        UserInfo userInfo = (UserInfo) request.getSession(true).getAttribute("userInfo");
        this.problemService.submitProblem(title, content, userInfo);
        return "redirect:/problem/myProblems.htm";
    }

    @RequestMapping("problemList")
    public String problemList(HttpServletRequest request) {
        List<Problem> problems = this.problemService.getProblemList();
        request.setAttribute("problems", problems);
        request.setAttribute("statusNames", ProblemStatus.statusNames);
        return "problem/problemList";
    }
    
    @RequestMapping("problemDetail")
    public String problemDetail(HttpServletRequest request) {
        String re = request.getParameter("re");
        String problemId = request.getParameter("problemId");
        Problem problem = this.problemService.getProblemById(problemId);
        request.setAttribute("re", re);
        request.setAttribute("problem", problem);
        return "problem/problemDetail";
    }
    
    @RequestMapping("processProblem")
    public String processProblem(HttpServletRequest request) {
        String problemId = request.getParameter("problemId");
        String re = request.getParameter("re");
        UserInfo userInfo = (UserInfo) request.getSession(true).getAttribute("userInfo");
        this.problemService.getProblemById(problemId);
        this.problemService.processProblem(problemId, re, userInfo);
        return "redirect:/problem/problemList.htm";
    }

}
