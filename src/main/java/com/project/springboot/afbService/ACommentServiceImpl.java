package com.project.springboot.afbService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.springboot.aboard.ACommentDTO;

@Service
public class ACommentServiceImpl implements IACommentService {

    @Autowired
    private ACommentService acm;

    @Override
    public List<ACommentDTO> getCommentList(int a_num) {
        return acm.getCommentList(a_num);
    }

    @Override
    public void writeComment(ACommentDTO acDto) {
        acm.writeComment(acDto);
    }

    @Override
    public void modifyComment(ACommentDTO acDto) {
        acm.modifyComment(acDto);
    }

    @Override
    public void deleteComment(int c_num) {
        acm.deleteComment(c_num);
    }
}