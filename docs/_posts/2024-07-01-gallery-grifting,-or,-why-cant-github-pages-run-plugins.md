---
project: blog 
---
I've been working on making a dedicated Gallery page for each Project on the blog. Some projects might have or need more images than others, so I wanted a central page linked from the main project page where all images can be shown at once. They'll have no context, at least for now. Maybe that could be added with a file in the `_data` folder, but for now, just having all the images in a central location is a good start.

{% include imagePost.html image="blogNotes1.jpg" %}

The images in this post are mostly just to test how the site handles multiple images. Before these two, there was just a single image, making for a fairly boring gallery. This shows how multiple images appear, both on posts, and on the Gallery page as well.

These images are smaller than the one I posted before. The previous image (of a grandfather clock movment) was 500x500, while these are 400x300. This should make a good comparison to see if I need to standardize how the images are rendered on the page. For now, either size seems to show up well enough, but if I end up using particularly big or small images in the future, it might be nice to know that's an option.

These images were edited with Gimp. I've used both Adobe Photoshop and the online resource Photopea in the past, but Gimp seems to be the image editor of choice for the aspiring Linux user. To be honest, it's probably a heavier program than I need, particularly working off of a Raspberry Pi, but if I end up needing a lighter program, I'm sure I can find an alternative. Learning Gimp wouldn't be a BAD thing, I'm sure it's popular for a reason.

{% include imagePost.html image="blogNotes2.jpg" %}

I was originally going to use a `display: grid` property for the Gallery page, but I think that `display: flex` seems to be working better. It allows the page to dynamically wrap the images in the gallery based on the browser width, compared to a set number of columns that a `<div>` set to `display: grid` would have. I've been thinking about converting the Projects list page to a grid format, so I'll have to keep this in mind.
