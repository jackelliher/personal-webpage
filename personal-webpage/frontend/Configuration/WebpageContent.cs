namespace frontend.Configuration;

public class WebpageContent
{
    public string ProfileImagePath { get; set; } = string.Empty;
    public IEnumerable<Article> Articles { get; set; } = Enumerable.Empty<Article>();
    public IEnumerable<Link> Links { get; set; } = Enumerable.Empty<Link>();
    public string BackgroundImagePath { get; set; } = string.Empty;
    public string FramePath { get; set; } = string.Empty;
    public string TitlePath { get; set; } = string.Empty;
    public string WallImagePath { get; set; } = string.Empty;
    public string TopFramePath { get; set; } = string.Empty;
    public string SideFramePath { get; set; } = string.Empty;
    public string CornerFramePath { get; set; } = string.Empty;
}

public class Link
{
    public string Href { get; set; } = string.Empty;
    public string DisplayText { get; set; } = string.Empty;
    public string? Description { get; set; }
}

public class Article
{
    public string Title { get; set; }
    public string Content { get; set; }
}