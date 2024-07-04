﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace FoodDelivery.Models
{
    [Table("restaurants")]
    public partial class Restaurant
    {
        public Restaurant()
        {
            Dishes = new HashSet<Dish>();
        }

        [Key]
        public int Id { get; set; }
        [Required]
        [StringLength(30)]
        [Unicode(false)]
        public string Name { get; set; }
        [Required]
        [StringLength(30)]
        public string Location { get; set; }
        [Required]
        [StringLength(150)]
        public string Address { get; set; }
        [Column("Monday-Friday_Open")]
        public TimeSpan MondayFridayOpen { get; set; }
        [Column("Monday-Friday_Close")]
        public TimeSpan MondayFridayClose { get; set; }
        [Column("Saturday-Sunday_Open")]
        public TimeSpan SaturdaySundayOpen { get; set; }
        [Column("Saturday-Sunday_Close")]
        public TimeSpan SaturdaySundayClose { get; set; }
        [StringLength(200)]
        public string Image { get; set; }
        [Column("Date fiscale")]
        [StringLength(400)]
        public string DateFiscale { get; set; }
        [StringLength(200)]
        public string Logo { get; set; }

        [InverseProperty("Restaurant")]
        public virtual ICollection<Dish> Dishes { get; set; }
    }
}