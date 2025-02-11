using System;
using System.Collections.Generic;

namespace vizsga3.Models;

public partial class Kartyak
{
    public int Id { get; set; }
    public string? Nev { get; set; }
    public int? Ar { get; set; }
    public string? Leiras { get; set; }
    public string? KepUrl { get; set; }
    public string? Kategoria { get; set; }
}
