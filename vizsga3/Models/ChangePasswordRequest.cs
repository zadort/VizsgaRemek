using System;
using System.Collections.Generic;

namespace vizsga3.Models
{
    public class ChangePasswordRequest
    {
        public int Id { get; set; }
        public string OldPassword { get; set; }
        public string NewPassword { get; set; }
    }
}
