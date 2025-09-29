import '../models/service_model.dart';

final List<Map<String, dynamic>> rawCategories = [
  {
    'name': "Vehicle Branding",
    'image': 'assets/images/services/1.webp',
    'description':
        "Complete vehicle care including custom wraps, polishing, window tinting, stickers, and passing assistance — all in one place.",
    'subcategories': [
      {
        'name': "Car Branding",
        'image': 'assets/images/sub-services/1.1.webp',
        'desc':
            "High-quality car branding solutions with premium vinyl films from trusted brands, ensuring vibrant colors, durability, and a professional finish for maximum brand visibility.",
        'materials': [
          {'name': "Gloss Vinyl Film (3M / Avery / Oracal)", 'ratePerSqFt': 10},
          {'name': "Matte Vinyl Film", 'ratePerSqFt': 12},
          {'name': "Color-Shift / Chrome Vinyl", 'ratePerSqFt': 18},
          {'name': "Cast Vinyl (Premium Long-Lasting)", 'ratePerSqFt': 15},
        ],
      },
      {
        'name': "Car Wrapping",
        'image': 'assets/images/sub-services/1.2.webp',
        'desc':
            "Transform your car’s appearance with durable wrapping finishes that protect paintwork while giving a stylish new look with gloss, matte, or chrome effects for a striking road presence.",
        'materials': [
          {'name': "Gloss Vinyl Wrap", 'ratePerSqFt': 12},
          {'name': "Matte Vinyl Wrap", 'ratePerSqFt': 14},
          {'name': "Chrome / Special Effect Wrap", 'ratePerSqFt': 25},
          {'name': "Cast Premium Long-Life Wrap", 'ratePerSqFt': 18},
        ],
      },
      {
        'name': "Windows Tinting",
        'image': 'assets/images/sub-services/1.3.webp',
        'desc':
            "Premium window tinting that enhances privacy, reduces heat, and blocks UV rays. Choose from standard, ceramic, or metallic options for comfort, protection, and a sleek appearance.",
        'materials': [
          {'name': "Standard Car Window Tint Film", 'ratePerSqFt': 8},
          {'name': "Ceramic Tint Film", 'ratePerSqFt': 15},
          {'name': "Metallic / Privacy Tint", 'ratePerSqFt': 12},
        ],
      },
      {
        'name': "PPF - Paint Protection Film",
        'image': 'assets/images/sub-services/1.4.webp',
        'desc':
            "Advanced paint protection films safeguard your vehicle against scratches, stone chips, and weather damage while preserving the showroom shine with matte, gloss, or satin finishes.",
        'materials': [
          {'name': "Standard Paint Protection Film", 'ratePerSqFt': 25},
          {'name': "Matte / Satin Finish PPF", 'ratePerSqFt': 30},
          {'name': "Gloss / Transparent PPF", 'ratePerSqFt': 28},
        ],
      },
      {
        'name': "Peelable Paints",
        'image': 'assets/images/sub-services/1.5.webp',
        'desc':
            "Custom peelable paint coatings offer a temporary yet durable color change for your vehicle. Available in gloss, matte, or chrome finishes, giving flexibility and easy removal when desired.",
        'materials': [
          {'name': "Gloss Finish Peelable Paint", 'ratePerSqFt': 18},
          {'name': "Matte Finish Peelable Paint", 'ratePerSqFt': 20},
          {'name': "Chrome / Special Effect Peelable Paint", 'ratePerSqFt': 35},
        ],
      },
      {
        'name': "Fleet Branding",
        'image': 'assets/images/sub-services/1.7.webp',
        'desc':
            "Professional fleet branding services with custom decals, partial wraps, and reflective stickers. Perfect for maximizing brand exposure while maintaining a professional corporate identity.",
        'materials': [
          {'name': "Custom Decals & Graphics", 'ratePerSqFt': 12},
          {'name': "Partial Sticker (Doors / Hood / Roof)", 'ratePerSqFt': 14},
          {'name': "Reflective / Specialty Stickers", 'ratePerSqFt': 18},
        ],
      },
      {
        'name': "Ceramic Coating",
        'image': 'assets/images/sub-services/1.8.webp',
        'desc':
            "Protect your car’s paint with advanced ceramic coating that offers superior gloss, water repellence, and scratch resistance. Keeps your vehicle looking new for years with minimal upkeep.",
        'materials': [
          {'name': "Standard Ceramic Coating (2 Layers)", 'ratePerUnit': 1200},
          {'name': "Premium Ceramic Coating (5 Layers)", 'ratePerUnit': 2000},
          {'name': "Graphene-Enhanced Ceramic Coating", 'ratePerUnit': 2500},
        ],
      },
      {
        'name': "RTA Approvals / Passing",
        'image': 'assets/images/sub-services/1.6.webp',
        'desc':
            "Full RTA approval and passing support for vehicle modifications, color changes, and registrations. Hassle-free service ensuring compliance with UAE regulations for a smooth experience.",
        'materials': [
          {'name': "Color Change Approval", 'rate': 400},
          {'name': "Full Passing & Registration Support", 'rate': 600},
        ],
      },
    ],
  },
  {
    'name': "Interior Fitouts",
    'image': 'assets/images/services/4.webp',
    'description':
        "Creative acrylic and decoration solutions that enhance interiors, signage, and displays with elegance, durability, and a modern professional finish.",
    "subcategories": [
      {
        "name": "Interior Designing",
        "image": "assets/images/sub-services/2.5.webp",
        "desc":
            "Complete interior design services for residential and commercial projects, blending modern aesthetics with functionality to create comfortable, elegant, and inspiring spaces.",
        "materials": [
          {"name": "Luxury Vinyl Tiles (LVT)", "ratePerSqFt": 15},
          {"name": "Fabric Wall Panels", "ratePerSqFt": 25},
          {"name": "Premium Decorative Paint", "ratePerSqFt": 18},
        ],
      },
      {
        "name": "Commercial Fit-outs",
        "image": "assets/images/sub-services/2.6.webp",
        "desc":
            "Professional turnkey fit-out solutions for offices, retail stores, and restaurants, designed to deliver functional layouts, stylish interiors, and durable finishes for businesses.",
        "materials": [
          {"name": "Acoustic Ceiling Tiles", "ratePerSqFt": 20},
          {"name": "Modular Glass Partitions", "ratePerSqFt": 35},
          {"name": "Engineered Wood Flooring", "ratePerSqFt": 30},
        ],
      },
      {
        "name": "Custom Carpentry",
        "image": "assets/images/sub-services/2.7.webp",
        "desc":
            "Tailor-made carpentry works including wardrobes, shelving, cabinets, and wooden décor crafted with precision, offering both practicality and premium aesthetics for interiors.",
        "materials": [
          {"name": "Solid Wood Cabinets", "ratePerSqFt": 45},
          {"name": "Laminate Finish Wardrobes", "ratePerSqFt": 28},
          {"name": "Custom MDF Furniture", "ratePerSqFt": 22},
        ],
      },
      {
        "name": "False Ceiling & Light Partitions",
        "image": "assets/images/sub-services/2.8.webp",
        "desc":
            "Modern false ceilings and gypsum light partitions designed for stylish interiors, enhancing ambiance, acoustic comfort, and lighting for residential and commercial environments.",
        "materials": [
          {"name": "Gypsum Board Ceiling", "ratePerSqFt": 15},
          {"name": "POP Decorative Ceiling", "ratePerSqFt": 18},
          {"name": "Acoustic Gypsum Panels", "ratePerSqFt": 22},
        ],
      },
      {
        "name": "Wood Flooring Works",
        "image": "assets/images/sub-services/2.9.webp",
        "desc":
            "Premium wood and laminate flooring services that enhance spaces with warmth and natural elegance, offering long-lasting durability for both modern and classic interiors.",
        "materials": [
          {"name": "Engineered Wood Flooring", "ratePerSqFt": 35},
          {"name": "HDF Laminate Flooring", "ratePerSqFt": 20},
          {"name": "Solid Hardwood Flooring", "ratePerSqFt": 50},
        ],
      },
      {
        "name": "Wallpapers and Paints",
        "image": "assets/images/sub-services/5.4.webp",
        "desc":
            "Transform your walls with premium wallpapers and paints in vibrant colors and unique textures. Ideal for creating stylish interiors that reflect personality and elegance in any space.",
        "materials": [
          {"name": "Matte Finish Digital Wallpaper", "ratePerSqFt": 12},
          {"name": "Textured Vinyl Wallpaper", "ratePerSqFt": 15},
          {"name": "Eco-Solvent Printed Wallpaper", "ratePerSqFt": 18},
        ],
      },
      {
        "name": "Wall Art",
        "image": "assets/images/sub-services/5.3.webp",
        "desc":
            "Creative wall art options including canvas, acrylic, and framed prints, crafted to add character, sophistication, and a striking visual appeal to residential and commercial spaces.",
        "materials": [
          {"name": "Canvas Art Prints", "ratePerSqFt": 18},
          {"name": "Acrylic Glass Panels", "ratePerSqFt": 25},
          {"name": "Framed Premium Posters", "ratePerSqFt": 20},
        ],
      },
    ],
  },
  {
    "name": "Digital Printing",
    "image": "assets/images/services/2.webp",
    "description":
        "Offering complete digital and printing solutions, including design, branding, marketing materials, and high-quality prints to meet all business needs.",
    "subcategories": [
      {
        "name": "Indoor / Outdoor Digital Printing",
        "image": "assets/images/sub-services/3.1.webp",
        "desc":
            "Premium indoor and outdoor digital printing solutions for posters, banners, and signage. Durable, high-resolution prints with vibrant colors for marketing and branding needs.",
        "materials": [
          {"name": "Standard Photo Paper 200gsm", "ratePerSqFt": 5},
          {"name": "Canvas Print (Matte)", "ratePerSqFt": 10},
          {"name": "Gloss Photo Paper 250gsm", "ratePerSqFt": 7},
        ],
      },
      {
        "name": "Large Format Printing",
        "image": "assets/images/sub-services/3.2.webp",
        "desc":
            "Eye-catching large format prints for banners, billboards, and displays. Durable outdoor materials with vivid colors designed to maximize visibility and brand impact.",
        "materials": [
          {"name": "PVC Banner Material", "ratePerSqFt": 12},
          {"name": "Mesh Banner", "ratePerSqFt": 15},
          {"name": "Backlit Film for Light Boxes", "ratePerSqFt": 20},
        ],
      },
      {
        "name": "Vehicle Graphics",
        "image": "assets/images/sub-services/3.5.webp",
        "desc":
            "Custom vehicle graphics and wraps for branding and advertising. UV-resistant, durable prints with vibrant colors to make your cars, vans, and fleets stand out on the road.",
        "materials": [
          {"name": "Vinyl Vehicle Sticker (Standard)", "ratePerSqFt": 10},
          {"name": "Reflective Vehicle Graphics", "ratePerSqFt": 15},
          {"name": "Perforated Window Film", "ratePerSqFt": 12},
        ],
      },
      {
        "name": "UV Printing",
        "image": "assets/images/sub-services/3.3.webp",
        "desc":
            "Advanced UV printing technology for acrylic, metal, and foam boards. Offers sharp, fade-resistant prints with direct-to-surface durability and a premium finish.",
        "materials": [
          {"name": "Acrylic UV Print", "ratePerSqFt": 20},
          {"name": "Foam Board UV Print", "ratePerSqFt": 15},
          {"name": "Metal Sheet UV Print", "ratePerSqFt": 25},
        ],
      },
      {
        "name": "Digital Fabric Printing",
        "image": "assets/images/sub-services/3.4.webp",
        "desc":
            "High-quality fabric printing for flags, soft signage, and displays. Durable, vibrant, and washable prints designed for exhibitions, retail branding, and promotional use.",
        "materials": [
          {"name": "Polyester Fabric Print", "ratePerSqFt": 12},
          {"name": "Satin Fabric Print", "ratePerSqFt": 15},
          {"name": "Backlit Fabric Print", "ratePerSqFt": 18},
        ],
      },
    ],
  },
  {
    "name": "Billboard & Signage",
    "image": "assets/images/services/3.webp",
    "description":
        "We provide complete board solutions, including design, printing, fabrication, and installation of display boards, branding boards, and custom creations.",
    "subcategories": [
      {
        "name": "Outdoor Signage",
        "image": "assets/images/sub-services/4.1.webp",
        "desc":
            "Durable and weather-resistant outdoor signage designed to boost visibility. Ideal for shopfronts, building facades, and high-traffic areas with lasting impact.",
        "materials": [
          {"name": "Aluminum Composite Panel (ACP)", "ratePerSqFt": 18},
          {"name": "Weatherproof PVC Board", "ratePerSqFt": 12},
          {"name": "LED Channel Letters", "ratePerLetter": 40},
        ],
      },
      {
        "name": "Indoor Signage",
        "image": "assets/images/sub-services/4.2.webp",
        "desc":
            "Custom indoor signage for offices, retail stores, and events. Delivers a clean, professional look to guide, inform, and enhance branding within interior spaces.",
        "materials": [
          {"name": "Acrylic Sheet Sign", "ratePerSqFt": 20},
          {"name": "Foam Board Sign", "ratePerSqFt": 8},
          {"name": "Vinyl Cut Lettering", "ratePerSqFt": 10},
        ],
      },
      {
        "name": "Billboards",
        "image": "assets/images/sub-services/4.5.webp",
        "desc":
            "High-visibility billboard solutions for impactful outdoor advertising. Perfect for highways, rooftops, and cityscapes with large-scale brand exposure.",
        "materials": [
          {"name": "Flex Billboard", "ratePerSqFt": 12},
          {"name": "Vinyl Billboard Print", "ratePerSqFt": 14},
          {"name": "3D / Custom Structure Billboard", "ratePerSqFt": 25},
        ],
      },
      {
        "name": "Acrylic Scooter Boards",
        "image": "assets/images/sub-services/2.1.webp",
        "desc":
            "Durable and stylish acrylic scooter boards designed for custom branding and advertising. Available in clear, colored, or mirror finishes for eye-catching displays.",
        "materials": [
          {"name": "Clear Cast Acrylic Sheet 5mm", "ratePerSqFt": 20},
          {"name": "Colored / Tinted Acrylic 5mm", "ratePerSqFt": 25},
          {"name": "Mirror Finish Acrylic 5mm", "ratePerSqFt": 30},
        ],
      },
      {
        "name": "Acrylic Sign Boards",
        "image": "assets/images/sub-services/2.2.webp",
        "desc":
            "Premium acrylic sign boards ideal for indoor and outdoor branding. Long-lasting, weather-resistant, and available in glossy, frosted, or backlit styles for modern signage.",
        "materials": [
          {"name": "Glossy Acrylic Sign Board", "ratePerSqFt": 22},
          {"name": "Frosted Acrylic Sign Board", "ratePerSqFt": 25},
          {"name": "Backlit Acrylic Sign Board", "ratePerSqFt": 28},
        ],
      },
      {
        "name": "Road Sign Boards",
        "image": "assets/images/sub-services/4.6.webp",
        "desc":
            "Durable road sign boards designed for maximum visibility and safety. Made with reflective materials and weatherproof finishes for highways, streets, and commercial use.",
        "materials": [
          {"name": "Aluminium Reflective Road Sign", "ratePerSqFt": 30},
          {
            "name": "ACP (Aluminium Composite Panel) Road Sign",
            "ratePerSqFt": 28,
          },
          {
            "name": "High-Intensity Prismatic Reflective Sign",
            "ratePerSqFt": 35,
          },
        ],
      },
      {
        "name": "Safety Signs",
        "image": "assets/images/sub-services/4.3.webp",
        "desc":
            "Regulation-compliant safety signage for workplaces, factories, and public spaces. Clear visuals ensure safety awareness and compliance with standards.",
        "materials": [
          {"name": "Reflective Safety Sign Board", "ratePerSqFt": 18},
          {"name": "Glow-in-the-Dark Safety Sign", "ratePerSqFt": 22},
          {"name": "Acrylic Safety Sign Plate", "ratePerSqFt": 15},
        ],
      },
    ],
  },
  {
    "name": "Digital Solutions",
    "image": "assets/images/services/5.webp",
    "description":
        "Advertising & Marketing services driving brand growth through creative campaigns, digital strategy, and targeted outreach to engage and convert audiences",
    "subcategories": [
      {
        "name": "Web Development",
        "image": "assets/images/sub-services/6.1.webp",
        "desc":
            "Custom websites designed for performance, responsiveness, and SEO. From corporate sites to e-commerce platforms, built to enhance your online presence.",
      },
      {
        "name": "Digital Marketing",
        "image": "assets/images/sub-services/6.2.webp",
        "desc":
            "Comprehensive digital marketing solutions including SEO, PPC, email campaigns, and online ads to maximize reach, drive traffic, and boost conversions.",
      },
      {
        "name": "Social Media Handling",
        "image": "assets/images/sub-services/6.3.webp",
        "desc":
            "End-to-end social media management for platforms like Instagram, Facebook, and LinkedIn. Content creation, posting, and engagement to grow your brand online.",
      },
      {
        "name": "Mobile App Development",
        "image": "assets/images/sub-services/6.4.webp",
        "desc":
            "Innovative mobile app solutions for iOS and Android. Scalable, user-friendly apps tailored to your business needs with modern design and smooth performance.",
      },
    ],
  },
];

final List<CategoryModel> categoryList = rawCategories
    .map((json) => CategoryModel.fromJson(json))
    .toList();

final List<ServiceModel> allServices = categoryList
    .expand((category) => category.subcategories)
    .toList();

// Popular services → first 2 from all services
final List<ServiceModel> popularServices = categoryList
    .expand((category) => (category.subcategories ?? []).take(2))
    .toList();
