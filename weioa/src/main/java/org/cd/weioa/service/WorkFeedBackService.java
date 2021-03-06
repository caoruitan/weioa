package org.cd.weioa.service;

import org.cd.weioa.dao.WorkFeedBackDao;
import org.cd.weioa.entity.WorkFeedBack;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

/**
 * Created by xuyang on 16/5/13.
 */
@Service
@Transactional
public class WorkFeedBackService {

    @Autowired
    private WorkFeedBackDao workFeedBackDao;

    public WorkFeedBack save(WorkFeedBack feedBack) {

        this.workFeedBackDao.save(feedBack);
        return feedBack;
    }

    public WorkFeedBack update(WorkFeedBack feedBack) {

        this.workFeedBackDao.deleteFiles(feedBack.getId());

        this.workFeedBackDao.update(feedBack);
        return feedBack;
    }

    public WorkFeedBack findByWorkNo(String workNo) {

        List<WorkFeedBack> feedBacks = this.workFeedBackDao.findByWorkNo(workNo);

        if(feedBacks == null || feedBacks.isEmpty()) {
            return null;
        }
        return feedBacks.get(0);
    }
}
