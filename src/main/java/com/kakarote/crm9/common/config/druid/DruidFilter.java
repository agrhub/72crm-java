package com.kakarote.crm9.common.config.druid;

import com.alibaba.druid.filter.FilterChain;
import com.alibaba.druid.filter.FilterEventAdapter;
import com.alibaba.druid.proxy.jdbc.*;
import java.sql.SQLException;
import java.util.Properties;

@SuppressWarnings("all")
@Deprecated
public class DruidFilter extends FilterEventAdapter {
    @Override
    public ConnectionProxy connection_connect(FilterChain chain, Properties info) throws SQLException {
        return super.connection_connect(chain, info);
    }

    @Override
    public void connection_connectBefore(FilterChain chain, Properties info) {
        super.connection_connectBefore(chain, info);
    }

    @Override
    public void connection_connectAfter(ConnectionProxy connection) {
        super.connection_connectAfter(connection);
    }

    @Override
    public StatementProxy connection_createStatement(FilterChain chain, ConnectionProxy connection) throws SQLException {
        return super.connection_createStatement(chain, connection);
    }

    @Override
    public StatementProxy connection_createStatement(FilterChain chain, ConnectionProxy connection, int resultSetType, int resultSetConcurrency) throws SQLException {
        return super.connection_createStatement(chain, connection, resultSetType, resultSetConcurrency);
    }

    @Override
    public StatementProxy connection_createStatement(FilterChain chain, ConnectionProxy connection, int resultSetType, int resultSetConcurrency, int resultSetHoldability) throws SQLException {
        return super.connection_createStatement(chain, connection, resultSetType, resultSetConcurrency, resultSetHoldability);
    }

    @Override
    public CallableStatementProxy connection_prepareCall(FilterChain chain, ConnectionProxy connection, String sql) throws SQLException {
        return super.connection_prepareCall(chain, connection, sql);
    }

    @Override
    public CallableStatementProxy connection_prepareCall(FilterChain chain, ConnectionProxy connection, String sql, int resultSetType, int resultSetConcurrency) throws SQLException {
        return super.connection_prepareCall(chain, connection, sql, resultSetType, resultSetConcurrency);
    }

    @Override
    public CallableStatementProxy connection_prepareCall(FilterChain chain, ConnectionProxy connection, String sql, int resultSetType, int resultSetConcurrency, int resultSetHoldability) throws SQLException {
        return super.connection_prepareCall(chain, connection, sql, resultSetType, resultSetConcurrency, resultSetHoldability);
    }

    @Override
    public PreparedStatementProxy connection_prepareStatement(FilterChain chain, ConnectionProxy connection, String sql) throws SQLException {
        return super.connection_prepareStatement(chain, connection, sql);
    }

    @Override
    public PreparedStatementProxy connection_prepareStatement(FilterChain chain, ConnectionProxy connection, String sql, int autoGeneratedKeys) throws SQLException {
        return super.connection_prepareStatement(chain, connection, sql, autoGeneratedKeys);
    }

    @Override
    public PreparedStatementProxy connection_prepareStatement(FilterChain chain, ConnectionProxy connection, String sql, int resultSetType, int resultSetConcurrency) throws SQLException {
        return super.connection_prepareStatement(chain, connection, sql, resultSetType, resultSetConcurrency);
    }

    @Override
    public PreparedStatementProxy connection_prepareStatement(FilterChain chain, ConnectionProxy connection, String sql, int resultSetType, int resultSetConcurrency, int resultSetHoldability) throws SQLException {
        return super.connection_prepareStatement(chain, connection, sql, resultSetType, resultSetConcurrency, resultSetHoldability);
    }

    @Override
    public PreparedStatementProxy connection_prepareStatement(FilterChain chain, ConnectionProxy connection, String sql, int[] columnIndexes) throws SQLException {
        return super.connection_prepareStatement(chain, connection, sql, columnIndexes);
    }

    @Override
    public PreparedStatementProxy connection_prepareStatement(FilterChain chain, ConnectionProxy connection, String sql, String[] columnNames) throws SQLException {
        return super.connection_prepareStatement(chain, connection, sql, columnNames);
    }

    @Override
    public boolean statement_execute(FilterChain chain, StatementProxy statement, String sql) throws SQLException {
        return super.statement_execute(chain, statement, sql);
    }

    @Override
    public boolean statement_execute(FilterChain chain, StatementProxy statement, String sql, int autoGeneratedKeys) throws SQLException {
        return super.statement_execute(chain, statement, sql, autoGeneratedKeys);
    }

    @Override
    public boolean statement_execute(FilterChain chain, StatementProxy statement, String sql, int[] columnIndexes) throws SQLException {
        return super.statement_execute(chain, statement, sql, columnIndexes);
    }

    @Override
    public boolean statement_execute(FilterChain chain, StatementProxy statement, String sql, String[] columnNames) throws SQLException {
        return super.statement_execute(chain, statement, sql, columnNames);
    }

    @Override
    public int[] statement_executeBatch(FilterChain chain, StatementProxy statement) throws SQLException {
        return super.statement_executeBatch(chain, statement);
    }

    @Override
    public ResultSetProxy statement_executeQuery(FilterChain chain, StatementProxy statement, String sql) throws SQLException {
        return super.statement_executeQuery(chain, statement, sql);
    }

    @Override
    public int statement_executeUpdate(FilterChain chain, StatementProxy statement, String sql) throws SQLException {
        return super.statement_executeUpdate(chain, statement, sql);
    }

    @Override
    public int statement_executeUpdate(FilterChain chain, StatementProxy statement, String sql, int autoGeneratedKeys) throws SQLException {
        return super.statement_executeUpdate(chain, statement, sql, autoGeneratedKeys);
    }

    @Override
    public int statement_executeUpdate(FilterChain chain, StatementProxy statement, String sql, int[] columnIndexes) throws SQLException {
        return super.statement_executeUpdate(chain, statement, sql, columnIndexes);
    }

    @Override
    public int statement_executeUpdate(FilterChain chain, StatementProxy statement, String sql, String[] columnNames) throws SQLException {
        return super.statement_executeUpdate(chain, statement, sql, columnNames);
    }

    @Override
    public ResultSetProxy statement_getGeneratedKeys(FilterChain chain, StatementProxy statement) throws SQLException {
        return super.statement_getGeneratedKeys(chain, statement);
    }

}
