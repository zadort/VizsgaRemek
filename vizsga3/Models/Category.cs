using System.Text.Json.Serialization;

public partial class Category
{
    public int Id { get; set; }

    [JsonPropertyName("category")]
    public string? Category1 { get; set; }
}
