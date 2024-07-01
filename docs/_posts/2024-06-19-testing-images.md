---
project: blog 
---
I'm using this post to test image placement and styling. This is basically just here as a testing ground.

{% include imagePost.html image="testImage.jpg" caption="This is a test caption! They can be shorter, but the can be longer, too! Text goes here!" %}

Well, I had to use SOMETHING for the test image. Something tasteful, something nice.

See, now I have to add a lot of text here. There used to be Lorem Ipsum in this block, but I figured I should add something of a bit more substance (well, that, and to stop the browser from offering to translate the page from Latin every time I refresh the page).

I need all this text here to test the wrapping feature on the image. I've added an attribute to the CSS telling the image to `float: right`, essentially forcing the image to the right and allowing any text to wrap around it. I figured it would be a more pleasing way to integrate the images into the post without it being plonked down in the middle of the page, pushing the rest of the text further down.

It's working well so far. The image here is 500x500, and it seems to be a decent size. The `include` function that injects the HTML should work with any sized image, so we'll just have to see if I encounter any issues as I continue to make posts.

I've also added a bit more depth to the `images` directory. There's now a folder for each project (or at least any projects that have images). This should make it easier to implement a Gallery page for each project, showing off all the images used for that project in one place. I don't have to specify the project name in the `include`, since it's already defined as the variable `project` in every post, but I can add a subdirectory to the `include` manually by defining a `projectShortName` variable. 

Site-wide images, such as the background image, are in a separate folder in `images` called `SITE`.
