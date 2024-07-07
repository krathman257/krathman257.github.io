# Project Blog

I've needed a place to put my thoughts and notes on my various programming projects for a while now. A place to rubber-duck issues, keep notes on my successes, and generally have as much as possible in a single spot. This blog is that spot.

This site is written using Jekyll, a static site generator that combines HTML, CSS, Ruby and Markdown to simplify making websites with a lot of repeated formatting and similar pages, such as blogs. The generator takes posts in the form of Markdown files and, using various HTML layouts and CSS stylings, automatically formats and organizes them into a site. The site itself is hosted on Github Pages.

## Making Pages

New pages are formatted as Markdown files, and include specific "front matter" at the beginning (marked off by the two lines of `---`) so that Jekyll knows certain variable values. Basic templates for the main types of new pages to create are kept in the `/docs/templates/` folder, and can be copied with the following command:

`cp docs/templates/[TEMPLATE] docs/[FOLDER]/[NEW NAME].md`

### Projects

The main `collection` on the blog is a collection of Projects. All posts and images go under one of these projects, and can be accessed from their main project page.

To make a new project, copy `projectTemplate.md` into `docs/_projects/` with a new name and a `.md` extension.

There are three variables that need to be assigned values: `short_name`, `name`, and `github`. `short_name` should be the same name as the file (this isn't required, but it keeps things intuitive), so `blog.md` should contain `short_name: blog`. `name` is the more human-readable name for the project, and should be something more descriptive (in this example, something like `name: Personal Project Blog`). `github` is an optional variable, and should be a link to the relavent Github repository, if used.

Any content, including Markdown-stylized text and images, to be shown on the main project page can be placed below the front matter.

### Posts

Posts create a sort of timeline, following my design process with a snapshot of the issue or success in the project that I felt was worth writing about. Jekyll automatically handles post formatting.

To make a new post, copy `postTemplate.md` into `docs/_posts/`, named after the following format:

`YYYY-MM-DD-[POST TITLE].md`

Jekyll will automatically set the date and title in the file name as variables to be referenced in the post.

To assign the post to a project, set the `project:` variable in the front matter. This should be the same as the `short_name` in the project you want to associate the post with.

Again, any content should be placed below the front matter.

### Galleries and Images

Each project can have a gallery page, showcasing all of the images associated with it. To add a gallery page, copy `galleryTemplate.md` into `docs/_galleries` with any name (with a `.md` extension), though it's best for the name to be the `short_name` of the project you want to associate it with.

Assign the `project:` variable to the `short_name` of the project it belongs to. Since the page is a simple image showcase, no content needs to be added below the front matter.

To add images to a project, for showcasing both in the gallery and in posts, create a folder in `docs/assets/images/` with the same name as the project's `short_name`. The project's gallery and posts can use the images in this folder (and *only* this folder).

## Helpful Syntax

Images can be placed into posts with the following Liquid `include` tag:

`{% include imagePost.html image="[IMAGE FILE]" caption="[TEXT]" %}`

The caption variable is optional. The command will automatically search in the folder in `docs/assets/images/` that has the same name as the `short_name` of the project associated with the post.

## Links

[Jekyll Documentation](http://jekyllrb.com/docs/)
