# Makefile for adb; from https://heiher.info/2227.html
SRCDIR:= $(PKG_BUILD_DIR)
VPATH+= $(SRCDIR)/core/adb
SRCS+= adb.c
SRCS+= adb_client.c
SRCS+= adb_auth_host.c
SRCS+= commandline.c
SRCS+= console.c
SRCS+= file_sync_client.c
SRCS+= fdevent.c
SRCS+= get_my_path_linux.c
SRCS+= services.c
SRCS+= sockets.c
SRCS+= transport.c
SRCS+= transport_local.c
SRCS+= transport_usb.c
SRCS+= usb_linux.c
SRCS+= usb_vendors.c
SRCS+= utils.c

VPATH+= $(SRCDIR)/core/libcutils
SRCS+= abort_socket.c
SRCS+= socket_inaddr_any_server.c
SRCS+= socket_local_client.c
SRCS+= socket_local_server.c
SRCS+= socket_loopback_client.c
SRCS+= socket_loopback_server.c
SRCS+= socket_network_client.c
SRCS+= list.c
SRCS+= load_file.c

VPATH+= $(SRCDIR)/core/libzipfile
SRCS+= centraldir.c
SRCS+= zipfile.c


CPPFLAGS+= -DADB_HOST=1
CPPFLAGS+= -DHAVE_FORKEXEC=1
CPPFLAGS+= -DHAVE_SYMLINKS
CPPFLAGS+= -DHAVE_TERMIO_H
CPPFLAGS+= -I$(SRCDIR)/core/adb
CPPFLAGS+= -I$(SRCDIR)/core/include

LIBS+= -lc -lpthread -lz `pkg-config --libs libcrypto` -lcrypt

OBJS= $(SRCS:.c=.o)

all: adb

adb: $(OBJS)
	$(CC) -o $@ $(LDFLAGS) $(OBJS) $(LIBS)

clean:
	rm -rf $(OBJS) adb
