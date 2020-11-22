REPO_DIR := $(realpath ./)
STUMP_DIR := $(REPO_DIR)/stumpwm
CONTRIB_DIR := $(REPO_DIR)/modules
CONTRIB_REPO := git@github.com:vdikan/stumpwm-contrib.git
CONTRIB_BRANCH := my-master

.PHONY: stump contrib links all clean

stump:
	git clone https://github.com/stumpwm/stumpwm.git $(STUMP_DIR)
	cd $(STUMP_DIR) && ./autogen.sh
	cd $(STUMP_DIR) && ./configure
	cd $(STUMP_DIR) && make
	cd $(STUMP_DIR) && sudo make install

contrib:
	git clone -b $(CONTRIB_BRANCH) $(CONTRIB_REPO) $(CONTRIB_DIR)

links:
	ln -s $(REPO_DIR)/stumpwmrc ~/.stumpwmrc
	ln -s $(REPO_DIR) ~/.stumpwm.d
	ln -s $(CONTRIB_DIR)/util/stumpish/stumpish ~/bin/stumpish

all:	stump contrib links

clean:
	rm -rf $(STUMP_DIR)
	rm -rf $(CONTRIB_DIR)
	rm ~/.stumpwmrc
	rm ~/.stumpwm.d
	rm ~/bin/stumpish
