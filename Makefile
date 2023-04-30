
.PHONY: init
init:
	hexo init output
	cd output && npm i hexo-theme-stellar && npm i

.PHONY: update
update:
	for path in $$(find markdown -type f -name "*.md"); do \
	  cp $${path} output/source/_posts; \
	done;
	cp hexo/* output
	mkdir -p output/source/images
	cp asset/* output/source/images

.PHONY: run
run:
	cd output && hexo server
