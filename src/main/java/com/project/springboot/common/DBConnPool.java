package com.project.springboot.common;

import java.io.Reader;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class DBConnPool {
    private static SqlSessionFactory sqlSessionFactory;
    private SqlSession session;

    public static DBConnPool getInstance() {
        return new DBConnPool();
    }

    static {
        try {
            Context initCtx = new InitialContext();
            Context ctx = (Context)initCtx.lookup("java:comp/env");
            DataSource dataSource = (DataSource)ctx.lookup("dbcp_myoracle");
            SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
            sqlSessionFactory = builder.build((Reader) dataSource.getConnection());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static SqlSession getSqlSession() throws Exception {
        SqlSession sqlSession = null;
        try {
            sqlSession = sqlSessionFactory.openSession();
        } catch (Exception e) {
            throw new Exception("SqlSession 생성 중 예외 발생", e);
        }
        return sqlSession;
    }

    public void close() throws Exception {
        if (session != null) {
            try {
                session.close();
            } catch (Exception e) {
                throw new Exception("SqlSession 종료 중 예외 발생", e);
            } finally {
                session = null;
            }
        }
    }
}
