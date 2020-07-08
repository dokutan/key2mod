build:
	$(CC) key2mod.c -o key2mod -O2 `pkg-config --cflags --libs libevdev`

install:
	install key2mod /usr/bin

uninstall:
	rm /usr/bin/key2mod

clean:
	rm key2mod
