package com.project.springboot.fboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.springboot.afbService.fboardService;
import com.project.springboot.fboard.fboardDTO;

@Repository
public class fboardMapperImpl implements fboardMapper {

    @Autowired
    private fboardService fboardService;
    
    @Override
    public List<fboardDTO> selectF() {
        return fboardService.selectF();
    }

    @Override
    public int insertF(fboardDTO fboardDto) {
        return fboardService.insertF(fboardDto);
    }

    @Override
    public fboardDTO selectOneF(String f_num) {
        return fboardService.selectOneF(f_num);
    }

    @Override
    public int updateF(fboardDTO fboardDto) {
        return fboardService.updateF(fboardDto);
    }

    @Override
    public int deleteF(fboardDTO fboardDto) {
        return fboardService.deleteF(fboardDto);
    }

}