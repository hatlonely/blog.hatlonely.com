
.PHONY: init
init:
	hexo init output && rm -rf output/source/_posts/hello-world.md
	cd output && npm install hexo-theme-stellar && npm install

.PHONY: update
update:
	for path in $$(find markdown -type f -name "*.md"); do \
	  cp $${path} output/source/_posts; \
	done;
	cp hexo/* output
	mkdir -p output/source/images
	cp -r images/* output/source/images

.PHONY: run
run:
	cd output && hexo server
