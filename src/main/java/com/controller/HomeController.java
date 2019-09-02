package com.controller;

import com.service.FileUploadService;
import java.io.IOException;
import java.io.InputStream;
import org.apache.commons.io.IOUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class HomeController {

    @Autowired
    FileUploadService fileUploadService;

    @RequestMapping("/")
    public String showHome(){
        return "home";
    }


    @RequestMapping("uploadImage.do")
    public @ResponseBody ResponseEntity uploadImage(@RequestParam("file") MultipartFile file){
        String url = fileUploadService.restore(file);
        JSONObject object = new JSONObject();
        object.put("location",url);
        String jsonStr = object.toJSONString();
        return new ResponseEntity(jsonStr,HttpStatus.OK);
    }

    @RequestMapping("template1.do")
    public String template1(){
        return "template1";
    }

    @RequestMapping("template2.do")
    public String template2(){
        return "template2";
    }

    @RequestMapping(value = "/getImage", produces = MediaType.IMAGE_JPEG_VALUE)
    public @ResponseBody byte[] getImageResources() throws IOException{
        InputStream in = getClass().getResourceAsStream("localhost:8888/uploadTinymce/2019720215200.jpg");
        return IOUtils.toByteArray(in);
    }

}
