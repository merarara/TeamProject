package com.project.springboot.cboard;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class C_BoardDAO {
    
    private SqlSession sqlSession;
    
    @Autowired
    public void setSqlSession(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }
    
    public int selectCount(Map<String, Object> map) {
        int totalCount = 0;
        String query = "SELECT COUNT(*) FROM C_Board";
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " "
                   + " LIKE '%" + map.get("searchWord") + "%'";
        }
        try {
            totalCount = sqlSession.selectOne(query);
        } catch (Exception e) {
            System.out.println("게시물 카운트 중 예외 발생");
            e.printStackTrace();
        }
        return totalCount;
    }
    
    public List<C_BoardDTO> selectListPage(Map<String, Object> map) {
        List<C_BoardDTO> board = null;
        String query = "SELECT * FROM ( "
                     + "    SELECT Tb.*, ROWNUM rNum FROM ( "
                     + "        SELECT * FROM C_Board ";
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField")
                   + " LIKE '%" + map.get("searchWord") + "%' ";
        }
        query += "        ORDER BY c_num DESC "
               + "    ) Tb "
               + " ) "
               + " WHERE rNum BETWEEN ? AND ?";
        try {
            board = sqlSession.selectList(query, map);
        } catch (Exception e) {
            System.out.println("게시물 조회 중 예외 발생");
            e.printStackTrace();
        }
        return board;
    }
    
    public int insertWrite(C_BoardDTO dto) {
        int result = 0;
        try {
            String query = "INSERT INTO C_Board (U_ID, C_title, C_content, C_ofile, C_sfile) " +
                           "VALUES (?, ?, ?, ?, ?)";
            result = sqlSession.insert("com.project.springboot.cboard.C_BoardMapper.insertWrite", dto);

            sqlSession.commit();
        } catch (Exception e) {
            System.out.println("게시물 입력 중 예외 발생");
            e.printStackTrace();
            sqlSession.rollback();
        }
        return result;
    }

    public C_BoardDTO selectView(int c_num) {
        C_BoardDTO dto = null;
        String query = "SELECT * FROM C_Board WHERE c_num=?";
        try {
            dto = sqlSession.selectOne(query, c_num);
        } catch (Exception e) {
            System.out.println("게시물 상세보기 중 예외 발생");
            e.printStackTrace();
        }
        return dto;
    }

    
    public void updatec_visitcount(int c_num) {
        String query = "UPDATE C_Board SET "
                     + " c_visitcount=c_visitcount+1 "
                     + " WHERE c_num=?";
        try {
            sqlSession.update(query, c_num);
            sqlSession.commit();
        } catch (Exception e) {
            System.out.println("게시물 조회수 증가 중 예외 발생");
            e.printStackTrace();
            sqlSession.rollback();
        }
    }
    public void close()
{
        sqlSession.close();
    }
}
