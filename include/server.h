#pragma once

#include <cstdlib>
#include <iostream>
#include <memory>
#include <utility>
#include <string>
#include <sstream>
#include <boost/asio.hpp>
#include <boost/filesystem.hpp>

using boost::asio::ip::tcp;

class Session : public std::enable_shared_from_this<Session>
{
public:
	Session(tcp::socket socket);
	
public:
	void Start();
	static void SetContext(boost::asio::io_context *io_context);

public:
	static boost::asio::io_context *io_context_;

private:
	void DoRead();
	void DoWrite(std::size_t length);
	void DoCGI();
	void SetEnv();
	void PrintEnv();

private:
	tcp::socket socket_;
	enum {max_length = 1024};
	char data_[max_length];	

private:
	std::string status_str;
	std::string REQUEST_METHOD;
	std::string REQUEST_URI;
	std::string QUERY_STRING;
	std::string SERVER_PROTOCOL;
	std::string HTTP_HOST;
	std::string SERVER_ADDR;
	std::string SERVER_PORT;
	std::string REMOTE_ADDR;
	std::string REMOTE_PORT;
	std::string EXEC_FILE;
};

class Server
{
public:
	Server(boost::asio::io_context& io_context, short port);
private:
	void DoAccept();

private:
	tcp::acceptor acceptor_;
};
