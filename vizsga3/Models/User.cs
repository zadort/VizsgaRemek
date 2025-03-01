using System;
using System.Collections.Generic;

namespace vizsga3.Models;

public partial class User
{
    public int Id { get; set; }

    public string? Username { get; set; }

    public string Password { get; set; } = null!;

    public string? Email { get; set; }
}
