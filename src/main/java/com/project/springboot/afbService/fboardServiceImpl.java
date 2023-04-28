package com.project.springboot.afbService;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.project.springboot.fboard.fboardDTO;

@Service
public class fboardServiceImpl implements fboardService {
	
	private fboardService fsv;
	
    @Override
    public List<fboardDTO> selectF() {
        return fsv.selectF();
    }

    @Override
    public int insertF(fboardDTO fboardDto) {
        return fsv.insertF(fboardDto);
    }

    @Override
    public fboardDTO selectOneF(String f_num) {
        return fsv.selectOneF(f_num);
    }

    @Override
    public int updateF(fboardDTO fboardDto) {
        return fsv.updateF(fboardDto);
    }

    @Override
    public int deleteF(fboardDTO fboardDto) {
        return fsv.deleteF(fboardDto);
    }
    
    @Override
    public List<fboardDTO> searchFboard(String searchField, String searchWord) {
        return fsv.searchFboard(searchField, searchWord);
    }

}
