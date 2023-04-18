package com.project.springboot.common;

import java.io.Reader;
import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class DBConnPool {
private static SqlSessionFactory sqlSessionFactory;
private static Reader reader;
private SqlSession session;
private Connection conn;
static {
    try {
        Context initCtx = new InitialContext();
        Context ctx = (Context)initCtx.lookup("java:comp/env");
        DataSource dataSource = (DataSource)ctx.lookup("dbcp_myoracle");
        SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
        sqlSessionFactory = builder.build((Reader) dataSource.getConnection().getMetaData().getConnection());
    } catch (Exception e) {
        e.printStackTrace();
    }
}

public SqlSession getSession() {
    try {
        session = sqlSessionFactory.openSession();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return session;
}

public void close() {
    try {
        session.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
}