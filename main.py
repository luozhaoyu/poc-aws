import socket
import MySQLdb

import config


def do_mysql(host, user, passwd, dbname):
    print host, user, passwd, dbname
    # connect
    db = MySQLdb.connect(host=host, user=user, passwd=passwd, db=dbname)

    cursor = db.cursor()

    # execute SQL select statement
    cursor.execute("show databases")

    # commit your changes
    db.commit()

    # get the number of rows in the resultset
    numrows = int(cursor.rowcount)

    content = ""
    # get and display one row at a time.
    for x in range(0,numrows):
        row = cursor.fetchone()
        content += "%s\n" % row
    return content

def main():
    HOST, PORT = '', 8888

    listen_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    listen_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    listen_socket.bind((HOST, PORT))
    listen_socket.listen(1)
    print 'Serving HTTP on port %s ...' % PORT
    basic = do_mysql(**config.mysql_config)
    print basic

    while True:
        client_connection, client_address = listen_socket.accept()
        request = client_connection.recv(1024)
        print request

        http_response = do_mysql(**config.mysql_config)
        client_connection.sendall(http_response)
        client_connection.close()
    
main()
