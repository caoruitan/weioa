package org.cd.weioa.service;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.cd.weioa.dao.ProblemDao;
import org.cd.weioa.entity.Problem;
import org.cd.weioa.entity.ProblemStatus;
import org.cd.weioa.weinxin.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class ProblemService {

    @Autowired
    private ProblemDao problemDao;

    public Problem submitProblem(String title, String content, UserInfo userInfo) {
        Problem problem = new Problem();
        problem.setTitle(title);
        problem.setContent(content);
        problem.setCreator(userInfo.getUserId());
        problem.setCreatorName(userInfo.getName());
        problem.setCreatorPhone(userInfo.getMobile());
        problem.setCreatorPhoto(userInfo.getPhoto());
        problem.setCreateTime(new Date());
        problem.setStatus(ProblemStatus.PROCESSING);
        this.problemDao.save(problem);
        return problem;
    }

    public void processProblem(String problemId) {
        Problem problem = this.problemDao.getEntityById(Problem.class, problemId);
        problem.setStatus(ProblemStatus.PROCESSED);
        this.problemDao.update(problem);
    }
    
    public Problem getProblemById(String problemId) {
        return this.problemDao.getEntityById(Problem.class, problemId);
    }
    
    public List<Problem> getProblemList() {
        return this.problemDao.getProblemList();
    }
    
    public List<Problem> getProblemListByCreator(String userId) {
        return this.problemDao.getProblemListByCreator(userId);
    }
}
