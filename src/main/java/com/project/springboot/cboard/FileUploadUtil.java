package com.project.springboot.cboard;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.ResourceUtils;
import org.springframework.web.multipart.MultipartFile;

public class FileUploadUtil {

	@Autowired 
	IboardService asv;
	
    public static String saveFile(MultipartFile file) {
        String sfile = "";

        try {
            // 디렉토리의 물리적 경로
            String path = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();

            // 저장할 파일명을 현재 시간으로 지정
            sfile = System.currentTimeMillis() + "_" + file.getOriginalFilename();

            // 경로와 파일명을 통해 File 객체를 생성
            File saveFile = new File(path, sfile);

            // 파일 저장
            file.transferTo(saveFile);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return sfile;
    }

    public static void deleteFile(String sfile) {
        // 파일 삭제
        String path = "";
        try {
            // 디렉토리의 물리적 경로
            path = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();

            // 경로와 파일명을 통해 File 객체를 생성
            File file = new File(path, sfile);

            // 해당 파일이 존재하는 경우 삭제
            if (file.exists()) {
                file.delete();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
