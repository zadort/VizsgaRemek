using System;
using System.Collections.Generic;

namespace vizsga3.Models;

public partial class Product
{
    public int Id { get; set; }

    public string? Name { get; set; }

    public int? Price { get; set; }

    public string? Description { get; set; }
    public string? Specs { get; set; }

    public string? Image { get; set; }

    public string? Category { get; set; }
}
