zip:
	@zip -r ../blackstar.love . -x='*.git*' -x='*.DS_Store'

test:
	@busted ./

.PHONY: zip test run