package com.project.springboot.fboard;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface fboardMapper {
    List<fboardDTO> selectF();
    int insertF(fboardDTO fboardDto);
    fboardDTO selectOneF(String f_num);
    int updateF(fboardDTO fboardDto);
    int deleteF(fboardDTO fboardDto);
}