package org.cd.weioa;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("test/")
public class TestAction {

    @RequestMapping("portal")
    public String test() {
        System.out.println("Hello World!");
        return "test";
    }

}
