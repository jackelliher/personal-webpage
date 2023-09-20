namespace frontend.Configuration;

public class WebpageContent
{
    public string ProfileImagePath { get; set; } = string.Empty;
    public IEnumerable<Article> Articles { get; set; } = Enumerable.Empty<Article>();
    public IEnumerable<Link> Links { get; set; } = Enumerable.Empty<Link>();
}

public class Link
{
    public string Href { get; set; }
    public string DisplayText { get; set; }
    public string? Description { get; set; }
}

public class Article
{
    public string Title { get; set; }
    public string Content { get; set; }
}