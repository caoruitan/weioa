package org.cd.weioa.action;

import org.cd.weioa.entity.FeedBackAttrType;
import org.cd.weioa.entity.WorkFeedBack;
import org.cd.weioa.service.WorkFeedBackService;
import org.cd.weioa.service.WorkOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.*;

/**
 * Created by xuyang on 16/5/10.
 */
@Controller
@RequestMapping( "workorder/feedback/" )
public class WorkFeedBackAction {

    @Autowired
    private WorkOrderService workOrderService;

    @Autowired
    private WorkFeedBackService workFeedBackService;

    @RequestMapping("")
    public String index() {
        return "feedback/index";
    }

    @RequestMapping("upload")
    @ResponseBody
    public Map<String, String> upload(HttpServletRequest request, MultipartFile file) {

        Map<String, String> result = new HashMap<>();

        if (!file.isEmpty()) {
            try {
                String path = request.getSession().getServletContext().getRealPath("upload/work");
                //拿到输出流，同时重命名上传的文件
                File uploadDir = new File(path + File.separator + new Date().getTime());

                if (!uploadDir.exists())
                    uploadDir.mkdirs();

                String suffix = file.getOriginalFilename().substring(
                        file.getOriginalFilename().lastIndexOf("."));

                File uploadFile = new File(uploadDir + File.separator + UUID.randomUUID().toString() + suffix);

                try {
                    file.transferTo(uploadFile);
                    result.put("url", "upload/work" +
                            File.separator + new Date().getTime() +
                            File.separator + UUID.randomUUID().toString() + suffix);
                    result.put("status", "success");

                } catch (IllegalStateException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }

            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("上传出错");
            }
        }
        return result;
    }


    @RequestMapping(value = "save")
    @ResponseBody
    public String save(WorkFeedBack feedBack,
                       @RequestParam(value = "workNames[]")String[] workNames,
                       @RequestParam(value = "workUrls[]") String[] workUrls,
                       @RequestParam(value = "financeNames[]")String[] financeNames,
                       @RequestParam(value = "financeUrls[]") String[] financeUrls) {

        for(int i = 0; i < workUrls.length; i++) {
            feedBack.addAttas(workUrls[i], FeedBackAttrType.WORK.getValue(), workNames[i]);
        }
        for(int j = 0; j < financeUrls.length; j++) {
            feedBack.addAttas(financeUrls[j], FeedBackAttrType.FINANCE.getValue(), financeNames[j]);
        }
        feedBack.setCreateTime(new Date());

        workFeedBackService.save(feedBack);

        return "{\"success\":true}";
    }

    @RequestMapping(value = "check")
    @ResponseBody
    public String check(String weixinNo, String workNo) {

        if(workOrderService.validateUserIdAndOrderId(weixinNo, workNo)) {
            return "{\"success\":true}";
        }
        return "{\"success\":false}";
    }
}
