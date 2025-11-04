import '../models/category_model.dart';

/// Default question bank for DORAK.
/// Each key represents a category ID (1–8), and the value is a list of challenges.
Map<String, List<Challenge>> defaultQuestionsByCategory() => {
      // 1️⃣ General Knowledge
      '1': [
        // 🟢 EASY (1–10)
        Challenge(
          id: 'gk_001',
          question: 'What is the capital of Saudi Arabia?',
          options: ['Riyadh', 'Jeddah', 'Doha', 'Dubai'],
          correctAnswer: 'Riyadh',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gk_002',
          question: 'What color is a ripe banana?',
          options: ['Green', 'Yellow', 'Red', 'Blue'],
          correctAnswer: 'Yellow',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gk_003',
          question: 'How many days are there in one week?',
          options: ['5', '6', '7', '8'],
          correctAnswer: '7',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gk_004',
          question: 'Which planet is known as the Red Planet?',
          options: ['Venus', 'Mars', 'Jupiter', 'Mercury'],
          correctAnswer: 'Mars',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gk_005',
          question: 'How many letters are in the English alphabet?',
          options: ['24', '25', '26', '27'],
          correctAnswer: '26',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gk_006',
          question: 'What do bees make?',
          options: ['Honey', 'Milk', 'Wax', 'Sugar'],
          correctAnswer: 'Honey',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gk_007',
          question: 'Which ocean is the largest?',
          options: ['Atlantic', 'Indian', 'Pacific', 'Arctic'],
          correctAnswer: 'Pacific',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gk_008',
          question: 'How many sides does a triangle have?',
          options: ['2', '3', '4', '5'],
          correctAnswer: '3',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gk_009',
          question: 'What is H₂O commonly known as?',
          options: ['Oxygen', 'Salt', 'Water', 'Hydrogen'],
          correctAnswer: 'Water',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gk_010',
          question: 'Which animal is known as the King of the Jungle?',
          options: ['Tiger', 'Lion', 'Elephant', 'Leopard'],
          correctAnswer: 'Lion',
          difficulty: ChallengeDifficulty.easy,
        ),

        // 🟡 MEDIUM (11–20)
        Challenge(
          id: 'gk_011',
          question: 'Who wrote the famous play “Romeo and Juliet”?',
          options: ['Shakespeare', 'Homer', 'Tolstoy', 'Charles Dickens'],
          correctAnswer: 'Shakespeare',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gk_012',
          question: 'What gas do plants produce during photosynthesis?',
          options: ['Oxygen', 'Carbon dioxide', 'Nitrogen', 'Hydrogen'],
          correctAnswer: 'Oxygen',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gk_013',
          question: 'What is the largest desert in the world?',
          options: ['Sahara', 'Arabian', 'Gobi', 'Antarctic'],
          correctAnswer: 'Antarctic',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gk_014',
          question: 'Which metal is liquid at room temperature?',
          options: ['Mercury', 'Gold', 'Silver', 'Aluminum'],
          correctAnswer: 'Mercury',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gk_015',
          question: 'Who was the first person to walk on the Moon?',
          options: [
            'Neil Armstrong',
            'Buzz Aldrin',
            'Yuri Gagarin',
            'Alan Shepard'
          ],
          correctAnswer: 'Neil Armstrong',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gk_016',
          question: 'Which continent has the most countries?',
          options: ['Asia', 'Europe', 'Africa', 'South America'],
          correctAnswer: 'Africa',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gk_017',
          question: 'What is the longest river in the world?',
          options: ['Nile', 'Amazon', 'Yangtze', 'Mississippi'],
          correctAnswer: 'Nile',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gk_018',
          question: 'Which country invented paper?',
          options: ['China', 'Egypt', 'India', 'Greece'],
          correctAnswer: 'China',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gk_019',
          question: 'In which year did World War II end?',
          options: ['1942', '1943', '1945', '1948'],
          correctAnswer: '1945',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gk_020',
          question: 'Which Gulf city is known as the “City of Gold”?',
          options: ['Dubai', 'Kuwait City', 'Riyadh', 'Doha'],
          correctAnswer: 'Dubai',
          difficulty: ChallengeDifficulty.medium,
        ),

        // 🔴 HARD (21–30)
        Challenge(
          id: 'gk_021',
          question: 'What is the chemical symbol for gold?',
          options: ['Au', 'Ag', 'Gd', 'Pt'],
          correctAnswer: 'Au',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gk_022',
          question: 'Who discovered the law of gravity?',
          options: ['Isaac Newton', 'Albert Einstein', 'Galileo', 'Archimedes'],
          correctAnswer: 'Isaac Newton',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gk_023',
          question: 'What is the smallest bone in the human body?',
          options: ['Stapes', 'Femur', 'Tibia', 'Ulna'],
          correctAnswer: 'Stapes',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gk_024',
          question: 'Which planet has the most moons?',
          options: ['Jupiter', 'Saturn', 'Neptune', 'Mars'],
          correctAnswer: 'Saturn',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gk_025',
          question: 'In which year was the United Nations founded?',
          options: ['1940', '1945', '1950', '1955'],
          correctAnswer: '1945',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gk_026',
          question: 'What is the hardest natural substance on Earth?',
          options: ['Gold', 'Iron', 'Diamond', 'Steel'],
          correctAnswer: 'Diamond',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gk_027',
          question: 'What is the currency of Japan?',
          options: ['Yuan', 'Yen', 'Won', 'Ringgit'],
          correctAnswer: 'Yen',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gk_028',
          question: 'Which element has the chemical symbol “Na”?',
          options: ['Sodium', 'Nitrogen', 'Nickel', 'Neon'],
          correctAnswer: 'Sodium',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gk_029',
          question: 'What is the capital city of Canada?',
          options: ['Toronto', 'Vancouver', 'Ottawa', 'Montreal'],
          correctAnswer: 'Ottawa',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gk_030',
          question: 'Who proposed the theory of relativity?',
          options: ['Einstein', 'Newton', 'Tesla', 'Curie'],
          correctAnswer: 'Einstein',
          difficulty: ChallengeDifficulty.hard,
        ),
      ],

      // 2️⃣ Family Life
      '2': [
        // 🟢 EASY (1–10)
        Challenge(
          id: 'fl_001',
          question: 'What is something families often do together on weekends?',
          options: [
            'Watch movies',
            'Go shopping',
            'Stay silent',
            'Work overtime'
          ],
          correctAnswer: 'Watch movies',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fl_002',
          question: 'Who is usually the oldest member in a family?',
          options: ['Father', 'Grandfather', 'Brother', 'Uncle'],
          correctAnswer: 'Grandfather',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fl_003',
          question:
              'What do most families eat together on Fridays in the Gulf?',
          options: ['Lunch', 'Breakfast', 'Dinner', 'Snacks'],
          correctAnswer: 'Lunch',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fl_004',
          question:
              'What do parents always tell their kids to finish before playing?',
          options: ['Homework', 'TV shows', 'Games', 'Calls'],
          correctAnswer: 'Homework',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fl_005',
          question: 'Who is usually in charge of cooking in most households?',
          options: ['Mother', 'Father', 'Children', 'Neighbor'],
          correctAnswer: 'Mother',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fl_006',
          question:
              'What’s something you say to your parents before leaving the house?',
          options: ['Goodbye', 'See you', 'I’m off', 'All of the above'],
          correctAnswer: 'All of the above',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fl_007',
          question: 'What’s the most common family pet?',
          options: ['Dog', 'Cat', 'Fish', 'Parrot'],
          correctAnswer: 'Cat',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fl_008',
          question: 'Who teaches manners and respect at home?',
          options: ['Parents', 'Friends', 'Teachers', 'TV'],
          correctAnswer: 'Parents',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fl_009',
          question: 'What do families usually celebrate together?',
          options: ['Eid', 'Birthdays', 'Graduations', 'All of the above'],
          correctAnswer: 'All of the above',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fl_010',
          question: 'Which room in the house brings the family together?',
          options: ['Living room', 'Kitchen', 'Garage', 'Bedroom'],
          correctAnswer: 'Living room',
          difficulty: ChallengeDifficulty.easy,
        ),

        // 🟡 MEDIUM (11–20)
        Challenge(
          id: 'fl_011',
          question: 'What’s one good way to make your family members happy?',
          options: ['Help them', 'Complain', 'Ignore them', 'Blame them'],
          correctAnswer: 'Help them',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fl_012',
          question: 'What is something families do during Ramadan evenings?',
          options: [
            'Eat together',
            'Watch TV',
            'Pray together',
            'All of the above'
          ],
          correctAnswer: 'All of the above',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fl_013',
          question: 'Who usually decides family vacation plans?',
          options: ['Parents', 'Children', 'Grandparents', 'Neighbors'],
          correctAnswer: 'Parents',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fl_014',
          question: 'What does a good family always show to one another?',
          options: ['Respect', 'Anger', 'Jealousy', 'Competition'],
          correctAnswer: 'Respect',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fl_015',
          question: 'What’s something families do together during Eid?',
          options: [
            'Visit relatives',
            'Go to work',
            'Sleep all day',
            'Travel alone'
          ],
          correctAnswer: 'Visit relatives',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fl_016',
          question: 'What should you say when a family member sneezes?',
          options: ['Bless you', 'Excuse me', 'Goodbye', 'Hello'],
          correctAnswer: 'Bless you',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fl_017',
          question: 'What helps families stay connected when living far apart?',
          options: [
            'Phone calls',
            'Ignoring each other',
            'No contact',
            'Letters only'
          ],
          correctAnswer: 'Phone calls',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fl_018',
          question: 'Which activity can strengthen family bonds?',
          options: [
            'Cooking together',
            'Arguing',
            'Playing separately',
            'Silent meals'
          ],
          correctAnswer: 'Cooking together',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fl_019',
          question: 'What do families in the Gulf enjoy doing at the beach?',
          options: ['Picnics', 'Volleyball', 'Swimming', 'All of the above'],
          correctAnswer: 'All of the above',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fl_020',
          question:
              'What’s a family value that is highly respected in Gulf culture?',
          options: [
            'Obedience to parents',
            'Competition',
            'Silence',
            'Independence'
          ],
          correctAnswer: 'Obedience to parents',
          difficulty: ChallengeDifficulty.medium,
        ),

        // 🔴 HARD (21–30)
        Challenge(
          id: 'fl_021',
          question: 'What’s one major benefit of eating together as a family?',
          options: [
            'Better communication',
            'Faster eating',
            'Less cleanup',
            'More screen time'
          ],
          correctAnswer: 'Better communication',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fl_022',
          question:
              'Which family tradition helps pass down values between generations?',
          options: [
            'Storytelling',
            'Shopping',
            'Online gaming',
            'Watching TV alone'
          ],
          correctAnswer: 'Storytelling',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fl_023',
          question: 'What can cause distance between family members?',
          options: ['Lack of communication', 'Respect', 'Love', 'Laughter'],
          correctAnswer: 'Lack of communication',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fl_024',
          question: 'Why is honesty important in a family?',
          options: [
            'It builds trust',
            'It causes fights',
            'It wastes time',
            'It makes things boring'
          ],
          correctAnswer: 'It builds trust',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fl_025',
          question: 'What’s one way parents can teach responsibility to kids?',
          options: [
            'Assign chores',
            'Ignore mistakes',
            'Do everything for them',
            'Reward laziness'
          ],
          correctAnswer: 'Assign chores',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fl_026',
          question: 'Why is patience important in family life?',
          options: [
            'To handle differences calmly',
            'To argue better',
            'To win',
            'To avoid help'
          ],
          correctAnswer: 'To handle differences calmly',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fl_027',
          question:
              'Which Gulf family event brings everyone together each year?',
          options: [
            'Eid gathering',
            'National Day parade',
            'Solo trip',
            'TV marathon'
          ],
          correctAnswer: 'Eid gathering',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fl_028',
          question: 'What’s an example of family teamwork?',
          options: [
            'Cleaning the house together',
            'Arguing',
            'Staying quiet',
            'Ignoring chores'
          ],
          correctAnswer: 'Cleaning the house together',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fl_029',
          question: 'Why should families practice gratitude?',
          options: [
            'It improves happiness',
            'It wastes time',
            'It causes problems',
            'It creates envy'
          ],
          correctAnswer: 'It improves happiness',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fl_030',
          question: 'What can children teach parents in modern families?',
          options: [
            'New technology',
            'Old traditions',
            'More rules',
            'Less respect'
          ],
          correctAnswer: 'New technology',
          difficulty: ChallengeDifficulty.hard,
        ),
      ],

      // 3️⃣ Gulf Culture
      '3': [
        // 🟢 EASY (1–10)
        Challenge(
          id: 'gc_001',
          question:
              'Which drink is traditionally served first to guests in the Gulf?',
          options: ['Arabic coffee (Gahwa)', 'Tea', 'Juice', 'Water'],
          correctAnswer: 'Arabic coffee (Gahwa)',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gc_002',
          question: 'What is the traditional Gulf bread called?',
          options: ['Regag', 'Tortilla', 'Chapati', 'Pita'],
          correctAnswer: 'Regag',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gc_003',
          question: 'What is the traditional clothing worn by Gulf men?',
          options: ['Kandura/Thobe', 'Kimono', 'Kurta', 'Suit'],
          correctAnswer: 'Kandura/Thobe',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gc_004',
          question: 'Which Gulf country is famous for pearl diving?',
          options: ['Bahrain', 'Kuwait', 'Oman', 'Qatar'],
          correctAnswer: 'Bahrain',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gc_005',
          question:
              'What do Gulf people usually eat to break their fast during Ramadan?',
          options: ['Dates', 'Rice', 'Soup', 'Salad'],
          correctAnswer: 'Dates',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gc_006',
          question: 'Which Gulf country has the tallest building in the world?',
          options: ['UAE', 'Kuwait', 'Qatar', 'Oman'],
          correctAnswer: 'UAE',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gc_007',
          question: 'What is a traditional Gulf dance called?',
          options: ['Ardah', 'Salsa', 'Ballet', 'Tango'],
          correctAnswer: 'Ardah',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gc_008',
          question: 'Which Gulf country’s capital city is Doha?',
          options: ['Qatar', 'Oman', 'Kuwait', 'Bahrain'],
          correctAnswer: 'Qatar',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gc_009',
          question: 'What is a traditional Gulf boat called?',
          options: ['Dhow', 'Canoe', 'Yacht', 'Submarine'],
          correctAnswer: 'Dhow',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'gc_010',
          question: 'What does the Arabic word “Yalla” mean?',
          options: ['Let’s go', 'Stop', 'Goodbye', 'Wait'],
          correctAnswer: 'Let’s go',
          difficulty: ChallengeDifficulty.easy,
        ),

        // 🟡 MEDIUM (11–20)
        Challenge(
          id: 'gc_011',
          question:
              'What is the Gulf traditional dish made of rice, meat, and spices?',
          options: ['Machboos', 'Pizza', 'Burger', 'Biryani'],
          correctAnswer: 'Machboos',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gc_012',
          question: 'Which Gulf city is home to the famous Souq Waqif?',
          options: ['Doha', 'Dubai', 'Muscat', 'Manama'],
          correctAnswer: 'Doha',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gc_013',
          question: 'What is the Gulf traditional fragrance made from wood?',
          options: ['Oud', 'Rose oil', 'Lavender', 'Musk'],
          correctAnswer: 'Oud',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gc_014',
          question: 'Which Gulf country celebrates National Day on December 2?',
          options: ['UAE', 'Kuwait', 'Bahrain', 'Oman'],
          correctAnswer: 'UAE',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gc_015',
          question: 'What type of headwear is traditionally worn by Gulf men?',
          options: ['Ghutra', 'Cap', 'Hat', 'Turban'],
          correctAnswer: 'Ghutra',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gc_016',
          question:
              'What are traditional Gulf women’s dresses often decorated with?',
          options: ['Gold thread embroidery', 'Beads', 'Paint', 'Buttons'],
          correctAnswer: 'Gold thread embroidery',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gc_017',
          question:
              'Which Gulf country is known as the “Land of Frankincense”?',
          options: ['Oman', 'Qatar', 'Kuwait', 'UAE'],
          correctAnswer: 'Oman',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gc_018',
          question:
              'What is the Gulf term for a close family gathering or evening meeting?',
          options: ['Diwaniya/Majlis', 'Bazaar', 'Cafe', 'Market'],
          correctAnswer: 'Diwaniya/Majlis',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gc_019',
          question: 'Which Gulf country has the island city of Muharraq?',
          options: ['Bahrain', 'Qatar', 'UAE', 'Saudi Arabia'],
          correctAnswer: 'Bahrain',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'gc_020',
          question:
              'What is the Gulf traditional hospitality gesture when guests arrive?',
          options: [
            'Serve coffee and dates',
            'Turn on music',
            'Offer gifts',
            'Cook a feast immediately'
          ],
          correctAnswer: 'Serve coffee and dates',
          difficulty: ChallengeDifficulty.medium,
        ),

        // 🔴 HARD (21–30)
        Challenge(
          id: 'gc_021',
          question:
              'Which Gulf country’s flag has a serrated white edge with nine points?',
          options: ['Qatar', 'Bahrain', 'Oman', 'Kuwait'],
          correctAnswer: 'Qatar',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gc_022',
          question: 'In which Gulf country is the Wahiba Sands desert located?',
          options: ['Oman', 'Saudi Arabia', 'Kuwait', 'Qatar'],
          correctAnswer: 'Oman',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gc_023',
          question:
              'What was the main economic activity in the Gulf before oil discovery?',
          options: [
            'Pearl diving and trading',
            'Fishing only',
            'Farming',
            'Gold mining'
          ],
          correctAnswer: 'Pearl diving and trading',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gc_024',
          question: 'What does the word “Habibi” mean in Arabic?',
          options: ['My dear', 'My friend', 'My teacher', 'My child'],
          correctAnswer: 'My dear',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gc_025',
          question:
              'Which Gulf festival celebrates heritage and traditional sports like camel racing?',
          options: [
            'Janadriyah Festival',
            'Eid Al-Fitr',
            'Hala February',
            'Ramadan Market'
          ],
          correctAnswer: 'Janadriyah Festival',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gc_026',
          question:
              'Which Gulf port city was historically called “the Venice of the Gulf”?',
          options: ['Kuwait City', 'Manama', 'Dubai', 'Muscat'],
          correctAnswer: 'Kuwait City',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gc_027',
          question:
              'Which traditional Gulf game is played with small seashells or stones?',
          options: ['Al-karam', 'Al-siniyah', 'Al-karamoh', 'Hawaleen'],
          correctAnswer: 'Al-karam',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gc_028',
          question: 'Which Gulf poet is known as the “Poet of a Million”?',
          options: [
            'Mohammed bin Rashid Al Maktoum',
            'Nizar Qabbani',
            'Prince Khalid Al-Faisal',
            'Abdulaziz Al-Qasimi'
          ],
          correctAnswer: 'Mohammed bin Rashid Al Maktoum',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gc_029',
          question:
              'What traditional Gulf jewelry piece is worn around the head or forehead by women?',
          options: ['Tikka', 'Burqa', 'Matha Patti', 'Mask of gold (Burqa)'],
          correctAnswer: 'Mask of gold (Burqa)',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'gc_030',
          question:
              'What do the colors of most Gulf flags symbolize? (Red, White, Green, Black)',
          options: [
            'Arab unity and courage',
            'Nature and peace',
            'Modernity',
            'Trade and culture'
          ],
          correctAnswer: 'Arab unity and courage',
          difficulty: ChallengeDifficulty.hard,
        ),
      ],

      // 4️⃣ Movies & TV (Gulf & Arabic Focus)
      // 4️⃣ Movies & TV (Gulf & Arabic Focus)
      '4': [
        // 🟢 EASY (1–10)
        Challenge(
          id: 'mv_001',
          question:
              'Which Gulf TV show is famous for its funny sketches during Ramadan?',
          options: [
            'Tash Ma Tash',
            'Selfie',
            'Shabab Al Bomb',
            'All of the above'
          ],
          correctAnswer: 'All of the above',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mv_002',
          question: 'Who is known as the “Father of Kuwaiti Theatre”?',
          options: [
            'Abdulhussain Abdulredha',
            'Saad Al-Faraj',
            'Nayef Al-Rodan',
            'Hayat Al-Fahad'
          ],
          correctAnswer: 'Abdulhussain Abdulredha',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mv_003',
          question:
              'Which country produced the popular TV show “Tash Ma Tash”?',
          options: ['Saudi Arabia', 'Kuwait', 'UAE', 'Bahrain'],
          correctAnswer: 'Saudi Arabia',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mv_004',
          question:
              'Which Arab country is famous for its film industry called “Hollywood of the Middle East”?',
          options: ['Egypt', 'Lebanon', 'Jordan', 'UAE'],
          correctAnswer: 'Egypt',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mv_005',
          question: 'Which actress is considered a legend of Kuwaiti TV drama?',
          options: [
            'Hayat Al-Fahad',
            'Soad Abdullah',
            'Haya Abdul Salam',
            'Muna Shaddad'
          ],
          correctAnswer: 'Soad Abdullah',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mv_006',
          question:
              'Which Gulf country often produces Ramadan TV dramas every year?',
          options: ['Kuwait', 'Oman', 'Bahrain', 'Yemen'],
          correctAnswer: 'Kuwait',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mv_007',
          question: 'What language are most Gulf TV series filmed in?',
          options: ['Khaliji Arabic', 'English', 'Egyptian Arabic', 'French'],
          correctAnswer: 'Khaliji Arabic',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mv_008',
          question:
              'What is the name of the famous Emirati comedy show featuring daily life humor?',
          options: ['Freej', 'Tash Ma Tash', 'Al Douri', 'Selfie'],
          correctAnswer: 'Freej',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mv_009',
          question:
              'Which TV show features old Gulf traditions and wisdom in a comedic way?',
          options: ['Darb Al Zalag', 'Freej', 'Selfie', 'Shaabiyat Al Cartoon'],
          correctAnswer: 'Darb Al Zalag',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mv_010',
          question: 'Who played the role of “Hassan” in “Darb Al Zalag”?',
          options: [
            'Abdulhussain Abdulredha',
            'Saad Al-Faraj',
            'Khaled Al-Nafisi',
            'Ali Al-Mufidi'
          ],
          correctAnswer: 'Abdulhussain Abdulredha',
          difficulty: ChallengeDifficulty.easy,
        ),

        // 🟡 MEDIUM (11–20)
        Challenge(
          id: 'mv_011',
          question:
              'What is the main theme of the Syrian series “Bab Al-Hara”?',
          options: [
            'Life in old Damascus',
            'Crime solving',
            'Science fiction',
            'Comedy'
          ],
          correctAnswer: 'Life in old Damascus',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mv_012',
          question:
              'Which Gulf actor starred in “Selfie,” known for social satire?',
          options: [
            'Nasser Al-Qasabi',
            'Abdulhussain Abdulredha',
            'Tariq Al-Ali',
            'Saad Al-Faraj'
          ],
          correctAnswer: 'Nasser Al-Qasabi',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mv_013',
          question: 'Which Kuwaiti actress is known as the “Queen of Drama”?',
          options: [
            'Hayat Al-Fahad',
            'Soad Abdullah',
            'Haya Abdul Salam',
            'Laila Abdullah'
          ],
          correctAnswer: 'Hayat Al-Fahad',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mv_014',
          question:
              'In which month do Gulf families usually enjoy new drama releases?',
          options: ['Ramadan', 'January', 'June', 'December'],
          correctAnswer: 'Ramadan',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mv_015',
          question: 'Which Arab singer starred in the movie “The Message”?',
          options: [
            'Abdallah Al Rowaished',
            'Omar Sharif',
            'Mohammed Abdo',
            'Mustafa Akkad'
          ],
          correctAnswer: 'Omar Sharif',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mv_016',
          question:
              'Which Emirati animated series celebrates traditional life and women’s friendship?',
          options: ['Freej', 'Shaabiyat Al Cartoon', 'Kids TV', 'Tash Ma Tash'],
          correctAnswer: 'Freej',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mv_017',
          question:
              'Which Gulf TV series was one of the first to tackle social issues openly?',
          options: ['Selfie', 'Tash Ma Tash', 'Shabab Al Bomb', 'Hob Wahd'],
          correctAnswer: 'Selfie',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mv_018',
          question:
              'Which Egyptian actor is famous for his role in “The Yacoubian Building”?',
          options: ['Adel Imam', 'Ahmed Helmy', 'Amr Diab', 'Mohamed Ramadan'],
          correctAnswer: 'Adel Imam',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mv_019',
          question: 'What is a common theme in Gulf family TV dramas?',
          options: [
            'Tradition and family values',
            'Fantasy worlds',
            'Action scenes',
            'Science fiction'
          ],
          correctAnswer: 'Tradition and family values',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mv_020',
          question:
              'Which Gulf actor is known for his comedic roles and popular stage performances?',
          options: [
            'Tariq Al-Ali',
            'Saad Al-Faraj',
            'Nasser Al-Qasabi',
            'Hayat Al-Fahad'
          ],
          correctAnswer: 'Tariq Al-Ali',
          difficulty: ChallengeDifficulty.medium,
        ),

        // 🔴 HARD (21–30)
        Challenge(
          id: 'mv_021',
          question: 'What was the first color TV series produced in Kuwait?',
          options: [
            'Darb Al Zalag',
            'Al Assouf',
            'Al Darb Al Taweel',
            'Bayt Al Tawa'
          ],
          correctAnswer: 'Darb Al Zalag',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mv_022',
          question:
              'Which Gulf director is known for blending modern storytelling with tradition?',
          options: [
            'Saud Al-Khalaf',
            'Ali Al-Kandari',
            'Hamad Al-Humaid',
            'Fahad Al-Mufarrej'
          ],
          correctAnswer: 'Ali Al-Kandari',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mv_023',
          question:
              'Which Arab TV channel is most known for premiering Ramadan dramas?',
          options: ['MBC', 'Dubai TV', 'Al Jazeera', 'Rotana Cinema'],
          correctAnswer: 'MBC',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mv_024',
          question:
              'Which Kuwaiti film was nominated at international festivals for best short film?',
          options: [
            'The Watermelon',
            'The Intruder',
            'Between the Sand and the Sea',
            'Hob El Awal'
          ],
          correctAnswer: 'The Watermelon',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mv_025',
          question:
              'What was the first Gulf movie to screen at Cannes Film Festival?',
          options: [
            'City of Life',
            'Letters to Palestine',
            'Wadjda',
            'Sea Shadow'
          ],
          correctAnswer: 'Wadjda',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mv_026',
          question:
              'Which Saudi film made history as the first directed by a woman?',
          options: [
            'Wadjda',
            'Barakah Meets Barakah',
            'The Perfect Candidate',
            'Scales'
          ],
          correctAnswer: 'Wadjda',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mv_027',
          question: 'Which Gulf actor is nicknamed “The Professor of Comedy”?',
          options: [
            'Abdulhussain Abdulredha',
            'Tariq Al-Ali',
            'Nasser Al-Qasabi',
            'Hayat Al-Fahad'
          ],
          correctAnswer: 'Abdulhussain Abdulredha',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mv_028',
          question:
              'Which UAE film told the story of friendship across generations?',
          options: ['Sea Shadow', 'City of Life', 'The Dreamer', 'The Diver'],
          correctAnswer: 'Sea Shadow',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mv_029',
          question:
              'Which Saudi TV drama follows family struggles during the 1970s oil boom?',
          options: ['Al Assouf', 'Selfie', 'Shabab Al Bomb', 'Hob Wahd'],
          correctAnswer: 'Al Assouf',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mv_030',
          question: 'Who is the famous Egyptian comedian known as “El Zaeem”?',
          options: [
            'Adel Imam',
            'Mohamed Henedy',
            'Ahmed Mekky',
            'Omar Sharif'
          ],
          correctAnswer: 'Adel Imam',
          difficulty: ChallengeDifficulty.hard,
        ),
      ],

      // 5️⃣ Music (Gulf & Arabic Focus)
      '5': [
        // 🟢 EASY (1–10)
        Challenge(
          id: 'mu_001',
          question: 'Who is known as the “Artist of the Arabs”?',
          options: [
            'Mohammed Abdu',
            'Rashed Al-Majed',
            'Abdallah Al Rowaished',
            'Kadim Al Sahir'
          ],
          correctAnswer: 'Mohammed Abdu',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mu_002',
          question:
              'Which Kuwaiti singer is known for the song “Ya Tayr El Hob”?',
          options: [
            'Abdallah Al Rowaished',
            'Nabeel Shuail',
            'Rashed Al-Majed',
            'Talal Maddah'
          ],
          correctAnswer: 'Abdallah Al Rowaished',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mu_003',
          question:
              'What instrument is commonly used in traditional Gulf music?',
          options: ['Oud', 'Guitar', 'Piano', 'Violin'],
          correctAnswer: 'Oud',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mu_004',
          question: 'Which Saudi singer performed “El Amaken”?',
          options: [
            'Mohammed Abdu',
            'Abdul Majeed Abdullah',
            'Rashed Al-Majed',
            'Nabeel Shuail'
          ],
          correctAnswer: 'Mohammed Abdu',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mu_005',
          question: 'Which Emirati singer is known for the hit “Ahebbak”?',
          options: [
            'Hussain Al Jassmi',
            'Balqees Fathi',
            'Fahad Al Kubaisi',
            'Abdul Majeed Abdullah'
          ],
          correctAnswer: 'Hussain Al Jassmi',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mu_006',
          question:
              'Which musical style features drums and rhythmic clapping at weddings?',
          options: ['Laywa', 'Hip hop', 'Jazz', 'Techno'],
          correctAnswer: 'Laywa',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mu_007',
          question: 'Which country is singer Rashed Al-Majed from?',
          options: ['Saudi Arabia', 'Kuwait', 'Qatar', 'UAE'],
          correctAnswer: 'Saudi Arabia',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mu_008',
          question: 'Which Emirati singer became popular with “Boshret Khair”?',
          options: [
            'Hussain Al Jassmi',
            'Majid Al Mohandis',
            'Abdul Majeed Abdullah',
            'Balqees Fathi'
          ],
          correctAnswer: 'Hussain Al Jassmi',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mu_009',
          question:
              'What is the traditional dance performed to live drumming in Gulf weddings?',
          options: ['Ardah', 'Samba', 'Ballet', 'Salsa'],
          correctAnswer: 'Ardah',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'mu_010',
          question: 'Which Kuwaiti artist is called “The Voice of Kuwait”?',
          options: [
            'Nabeel Shuail',
            'Abdallah Al Rowaished',
            'Bader Al Shuaibi',
            'Rashed Al-Majed'
          ],
          correctAnswer: 'Nabeel Shuail',
          difficulty: ChallengeDifficulty.easy,
        ),

        // 🟡 MEDIUM (11–20)
        Challenge(
          id: 'mu_011',
          question:
              'Which Iraqi artist is known as “The Caesar of Arabic Song”?',
          options: [
            'Kadim Al Sahir',
            'Majid Al Mohandis',
            'Saber Rebai',
            'Amr Diab'
          ],
          correctAnswer: 'Kadim Al Sahir',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mu_012',
          question:
              'Which Saudi artist is known for the song “Ya Taib El Galb”?',
          options: [
            'Abdul Majeed Abdullah',
            'Mohammed Abdu',
            'Majid Al Mohandis',
            'Rashed Al-Majed'
          ],
          correctAnswer: 'Abdul Majeed Abdullah',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mu_013',
          question:
              'Which female Emirati singer is the daughter of Ahmed Fathi?',
          options: [
            'Balqees Fathi',
            'Ahlam Al Shamsi',
            'Diana Haddad',
            'Shamma Hamdan'
          ],
          correctAnswer: 'Balqees Fathi',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mu_014',
          question: 'Which Egyptian pop singer is famous for “Tamally Maak”?',
          options: ['Amr Diab', 'Tamer Hosny', 'Mohamed Hamaki', 'Ramy Sabry'],
          correctAnswer: 'Amr Diab',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mu_015',
          question:
              'Which Gulf traditional instrument produces deep drum beats?',
          options: ['Mirwas', 'Tabla', 'Tambourine', 'Cajón'],
          correctAnswer: 'Mirwas',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mu_016',
          question: 'Which Lebanese singer is known for her hit “Ya Tabtab”?',
          options: ['Nancy Ajram', 'Elissa', 'Haifa Wehbe', 'Myriam Fares'],
          correctAnswer: 'Nancy Ajram',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mu_017',
          question:
              'Which Gulf artist famously sang at Expo 2020 Dubai opening?',
          options: [
            'Ahlam Al Shamsi',
            'Hussain Al Jassmi',
            'Balqees Fathi',
            'Rashed Al-Majed'
          ],
          correctAnswer: 'Hussain Al Jassmi',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mu_018',
          question:
              'Which Saudi musician is known for blending pop and traditional sounds?',
          options: [
            'Abdul Majeed Abdullah',
            'Tariq Al-Harbi',
            'Rashed Al-Majed',
            'Talal Maddah'
          ],
          correctAnswer: 'Rashed Al-Majed',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mu_019',
          question: 'Which Gulf female singer is known as “Queen of Stage”?',
          options: [
            'Ahlam Al Shamsi',
            'Balqees Fathi',
            'Diana Haddad',
            'Shamma Hamdan'
          ],
          correctAnswer: 'Ahlam Al Shamsi',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'mu_020',
          question:
              'Which Arabic song became a global hit with its “Habibi” lyrics?',
          options: [
            'Habibi Ya Nour El Ain',
            'Ya Tabtab',
            'Ahebbak',
            'Tamally Maak'
          ],
          correctAnswer: 'Habibi Ya Nour El Ain',
          difficulty: ChallengeDifficulty.medium,
        ),

        // 🔴 HARD (21–30)
        Challenge(
          id: 'mu_021',
          question: 'Who composed the Saudi national anthem?',
          options: [
            'Ibrahim Khafaji',
            'Talal Maddah',
            'Abdulrahman Al-Khateeb',
            'Abdul Majeed Abdullah'
          ],
          correctAnswer: 'Ibrahim Khafaji',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mu_022',
          question:
              'Which Kuwaiti composer is known for shaping the Gulf musical identity?',
          options: [
            'Ahmad Baqer',
            'Bader Al Shuaibi',
            'Mohammed Shams',
            'Nabeel Shuail'
          ],
          correctAnswer: 'Ahmad Baqer',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mu_023',
          question:
              'Which Gulf singer was called “The Golden Voice of Arabia”?',
          options: [
            'Talal Maddah',
            'Mohammed Abdu',
            'Abdul Majeed Abdullah',
            'Rashed Al-Majed'
          ],
          correctAnswer: 'Talal Maddah',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mu_024',
          question:
              'Which country is home to the annual “Winter at Tantora” music festival?',
          options: ['Saudi Arabia', 'Kuwait', 'UAE', 'Bahrain'],
          correctAnswer: 'Saudi Arabia',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mu_025',
          question:
              'Which musical form combines poetry and rhythm in Gulf tradition?',
          options: ['Samri', 'Ardah', 'Laywa', 'Khaleeji pop'],
          correctAnswer: 'Samri',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mu_026',
          question:
              'Which Gulf singer collaborated with international artist RedOne?',
          options: [
            'Ahlam Al Shamsi',
            'Balqees Fathi',
            'Rashed Al-Majed',
            'Abdul Majeed Abdullah'
          ],
          correctAnswer: 'Balqees Fathi',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mu_027',
          question: 'Which Bahraini singer is known for the song “Ma’ak Rouh”?',
          options: [
            'Hala Al Turk',
            'Ahmed Al Jumairi',
            'Isa Qattan',
            'Khaled Fouad'
          ],
          correctAnswer: 'Ahmed Al Jumairi',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mu_028',
          question:
              'Which legendary Egyptian singer was known as “Kawkab El Sharq” (Star of the East)?',
          options: [
            'Umm Kulthum',
            'Fairouz',
            'Abdel Halim Hafez',
            'Warda Al Jazairia'
          ],
          correctAnswer: 'Umm Kulthum',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mu_029',
          question:
              'Which Gulf musician pioneered the modern “Khaleeji pop” genre?',
          options: [
            'Rashed Al-Majed',
            'Talal Maddah',
            'Abdallah Al Rowaished',
            'Mohammed Abdu'
          ],
          correctAnswer: 'Rashed Al-Majed',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'mu_030',
          question:
              'Which Arabic singer performed the famous song “Enta Omri”?',
          options: ['Umm Kulthum', 'Fairouz', 'Warda', 'Samira Said'],
          correctAnswer: 'Umm Kulthum',
          difficulty: ChallengeDifficulty.hard,
        ),
      ],

      // 6️⃣ Funny Challenges
      '6': [
        // 🟢 EASY (1–10) — Light and silly fun
        Challenge(
          id: 'fc_001',
          question: 'Make your teammates laugh in under 15 seconds!',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fc_002',
          question: 'Talk like a robot for the next 20 seconds.',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fc_003',
          question: 'Act like a cat trying to catch a laser pointer.',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fc_004',
          question: 'Say your full name backward as fast as you can.',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fc_005',
          question: 'Pretend you are a famous singer performing on stage.',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fc_006',
          question: 'Dance without music for 10 seconds.',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fc_007',
          question: 'Imitate a crying baby until everyone laughs.',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fc_008',
          question:
              'Say “Dorak” five times as fast as possible without mistakes.',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fc_009',
          question:
              'Pretend your hand is a phone and talk to your “best friend.”',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'fc_010',
          question:
              'Stand on one leg for 10 seconds while saying the alphabet backward.',
          difficulty: ChallengeDifficulty.easy,
        ),

        // 🟡 MEDIUM (11–20) — More movement & interaction
        Challenge(
          id: 'fc_011',
          question:
              'Do 10 jumping jacks while making a funny sound after each one.',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fc_012',
          question: 'Act like an animal your team chooses for 15 seconds.',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fc_013',
          question: 'Hold a silly face for 10 seconds without laughing.',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fc_014',
          question: 'Pretend you are stuck inside a box and try to get out.',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fc_015',
          question: 'Spin around three times, then walk in a straight line.',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fc_016',
          question: 'Say everything you speak for the next 30 seconds in song.',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fc_017',
          question: 'Act out brushing your teeth in slow motion.',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fc_018',
          question:
              'Pretend to interview your teammate as if they are a celebrity.',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fc_019',
          question: 'Make up a dance move and name it after yourself.',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'fc_020',
          question: 'Tell a one-minute story using only animal sounds.',
          difficulty: ChallengeDifficulty.medium,
        ),

        // 🔴 HARD (21–30) — Team coordination or silly dares
        Challenge(
          id: 'fc_021',
          question:
              'Balance something on your head for 20 seconds without dropping it.',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fc_022',
          question: 'Do 10 push-ups while your team cheers you on.',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fc_023',
          question:
              'Act like a news reporter giving “breaking news” about your team.',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fc_024',
          question: 'Imitate your teammate’s laugh until everyone laughs.',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fc_025',
          question:
              'Say a tongue twister five times correctly: “She sells seashells by the seashore.”',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fc_026',
          question:
              'Make up a commercial for an imaginary product (like “Invisible Shoes”).',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fc_027',
          question: 'Pretend to be a chef teaching how to cook “air soup.”',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fc_028',
          question: 'Spin in a circle while singing your favorite song.',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fc_029',
          question:
              'Pass the phone to another player while clapping rhythmically.',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'fc_030',
          question:
              'Do your best imitation of a famous movie villain for 20 seconds.',
          difficulty: ChallengeDifficulty.hard,
        ),
      ],

      // 7️⃣ Kids Corner
      '7': [
        // 🟢 EASY (1–10)
        Challenge(
          id: 'kc_001',
          question: 'What color is the sky on a clear, sunny day?',
          options: ['Blue', 'Green', 'Red', 'Purple'],
          correctAnswer: 'Blue',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'kc_002',
          question: 'How many legs does a cat have?',
          options: ['Four', 'Two', 'Six', 'Eight'],
          correctAnswer: 'Four',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'kc_003',
          question: 'Which animal says “Moo”?',
          options: ['Cow', 'Dog', 'Sheep', 'Cat'],
          correctAnswer: 'Cow',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'kc_004',
          question: 'What do bees make?',
          options: ['Honey', 'Milk', 'Butter', 'Juice'],
          correctAnswer: 'Honey',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'kc_005',
          question: 'What is 2 + 3?',
          options: ['4', '5', '6', '3'],
          correctAnswer: '5',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'kc_006',
          question:
              'Which fruit keeps the doctor away if you eat one every day?',
          options: ['Apple', 'Banana', 'Orange', 'Mango'],
          correctAnswer: 'Apple',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'kc_007',
          question: 'What color are bananas when they are ripe?',
          options: ['Yellow', 'Green', 'Red', 'Brown'],
          correctAnswer: 'Yellow',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'kc_008',
          question: 'Which planet do we live on?',
          options: ['Earth', 'Mars', 'Venus', 'Jupiter'],
          correctAnswer: 'Earth',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'kc_009',
          question: 'What do you call a baby dog?',
          options: ['Puppy', 'Kitten', 'Cub', 'Chick'],
          correctAnswer: 'Puppy',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'kc_010',
          question: 'Which shape has three sides?',
          options: ['Triangle', 'Square', 'Circle', 'Star'],
          correctAnswer: 'Triangle',
          difficulty: ChallengeDifficulty.easy,
        ),

        // 🟡 MEDIUM (11–20)
        Challenge(
          id: 'kc_011',
          question: 'What do plants need to make their food?',
          options: ['Sunlight', 'Moonlight', 'Wind', 'Snow'],
          correctAnswer: 'Sunlight',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'kc_012',
          question: 'Which animal is known as the “King of the Jungle”?',
          options: ['Lion', 'Elephant', 'Tiger', 'Bear'],
          correctAnswer: 'Lion',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'kc_013',
          question: 'What do you call the person who flies an airplane?',
          options: ['Pilot', 'Driver', 'Captain', 'Mechanic'],
          correctAnswer: 'Pilot',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'kc_014',
          question: 'How many days are there in a week?',
          options: ['7', '5', '10', '12'],
          correctAnswer: '7',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'kc_015',
          question: 'Which animal can live both in water and on land?',
          options: ['Frog', 'Fish', 'Dog', 'Bird'],
          correctAnswer: 'Frog',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'kc_016',
          question: 'What do you use to brush your teeth?',
          options: ['Toothbrush', 'Spoon', 'Comb', 'Towel'],
          correctAnswer: 'Toothbrush',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'kc_017',
          question: 'Which Gulf country has the Burj Khalifa?',
          options: ['UAE', 'Qatar', 'Saudi Arabia', 'Bahrain'],
          correctAnswer: 'UAE',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'kc_018',
          question: 'What color do you get when you mix blue and yellow?',
          options: ['Green', 'Red', 'Purple', 'Orange'],
          correctAnswer: 'Green',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'kc_019',
          question: 'What is the opposite of “hot”?',
          options: ['Cold', 'Warm', 'Wet', 'Cool'],
          correctAnswer: 'Cold',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'kc_020',
          question: 'Which season comes after spring?',
          options: ['Summer', 'Winter', 'Autumn', 'Rainy'],
          correctAnswer: 'Summer',
          difficulty: ChallengeDifficulty.medium,
        ),

        // 🔴 HARD (21–30)
        Challenge(
          id: 'kc_021',
          question: 'What gas do humans breathe in to live?',
          options: ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
          correctAnswer: 'Oxygen',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'kc_022',
          question: 'Which planet is known as the Red Planet?',
          options: ['Mars', 'Venus', 'Mercury', 'Jupiter'],
          correctAnswer: 'Mars',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'kc_023',
          question: 'What do you call a baby cow?',
          options: ['Calf', 'Foal', 'Cub', 'Pup'],
          correctAnswer: 'Calf',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'kc_024',
          question: 'What is the largest mammal in the world?',
          options: ['Blue Whale', 'Elephant', 'Shark', 'Giraffe'],
          correctAnswer: 'Blue Whale',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'kc_025',
          question: 'Which country is famous for making pizza?',
          options: ['Italy', 'France', 'Egypt', 'Greece'],
          correctAnswer: 'Italy',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'kc_026',
          question: 'Which instrument has black and white keys?',
          options: ['Piano', 'Drum', 'Guitar', 'Violin'],
          correctAnswer: 'Piano',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'kc_027',
          question: 'What is the process called when water turns into vapor?',
          options: ['Evaporation', 'Condensation', 'Freezing', 'Boiling'],
          correctAnswer: 'Evaporation',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'kc_028',
          question: 'Which Gulf city is known for its man-made Palm Island?',
          options: ['Dubai', 'Doha', 'Muscat', 'Manama'],
          correctAnswer: 'Dubai',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'kc_029',
          question: 'What is the fastest land animal?',
          options: ['Cheetah', 'Lion', 'Horse', 'Gazelle'],
          correctAnswer: 'Cheetah',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'kc_030',
          question:
              'What do you call the small holes on your skin that sweat comes from?',
          options: ['Pores', 'Spots', 'Cells', 'Glands'],
          correctAnswer: 'Pores',
          difficulty: ChallengeDifficulty.hard,
        ),
      ],

      // 8️⃣ Quick Thinking
      '8': [
        // 🟢 EASY (1–10)
        Challenge(
          id: 'qt_001',
          question: 'Name a fruit that is yellow.',
          options: ['Banana', 'Lemon', 'Mango', 'Pineapple'],
          correctAnswer: 'Banana',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'qt_002',
          question: 'What color do you get when you mix red and white?',
          options: ['Pink', 'Orange', 'Brown', 'Purple'],
          correctAnswer: 'Pink',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'qt_003',
          question: 'Say the word “fast” five times without stopping!',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'qt_004',
          question: 'Name something you can wear on your head.',
          options: ['Hat', 'Cap', 'Scarf', 'Helmet'],
          correctAnswer: 'Hat',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'qt_005',
          question: 'Clap your hands 10 times as fast as you can!',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'qt_006',
          question: 'What is 10 - 3?',
          options: ['7', '6', '8', '5'],
          correctAnswer: '7',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'qt_007',
          question: 'Spell the word “GAME” backward.',
          correctAnswer: 'EMAG',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'qt_008',
          question: 'Name any animal that can fly.',
          options: ['Bird', 'Bat', 'Eagle', 'Butterfly'],
          correctAnswer: 'Bird',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'qt_009',
          question: 'Say the names of 3 Gulf countries in 10 seconds!',
          difficulty: ChallengeDifficulty.easy,
        ),
        Challenge(
          id: 'qt_010',
          question: 'Name something you use every morning.',
          options: ['Toothbrush', 'Phone', 'Towel', 'All of the above'],
          correctAnswer: 'All of the above',
          difficulty: ChallengeDifficulty.easy,
        ),

        // 🟡 MEDIUM (11–20)
        Challenge(
          id: 'qt_011',
          question: 'List 3 animals that live in water.',
          correctAnswer: 'Fish, Dolphin, Whale',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'qt_012',
          question: 'Name something round other than a ball.',
          options: ['Plate', 'Coin', 'Clock', 'All of the above'],
          correctAnswer: 'All of the above',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'qt_013',
          question: 'Say 5 words that start with the letter “S.”',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'qt_014',
          question: 'Name 3 Gulf countries that start with a vowel.',
          correctAnswer: 'Oman, UAE',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'qt_015',
          question: 'Count from 1 to 10 in under 3 seconds!',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'qt_016',
          question: 'If you have 5 apples and give 2 away, how many are left?',
          options: ['3', '2', '5', '1'],
          correctAnswer: '3',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'qt_017',
          question: 'Name 3 things that use electricity.',
          options: ['Phone', 'TV', 'Fan', 'All of the above'],
          correctAnswer: 'All of the above',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'qt_018',
          question: 'Say the alphabet without the letter “A.”',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'qt_019',
          question: 'Name one Gulf country and its capital.',
          options: [
            'Kuwait – Kuwait City',
            'UAE – Abu Dhabi',
            'Qatar – Doha',
            'All of the above'
          ],
          correctAnswer: 'All of the above',
          difficulty: ChallengeDifficulty.medium,
        ),
        Challenge(
          id: 'qt_020',
          question: 'Name 3 things that are cold.',
          options: ['Ice', 'Snow', 'Juice', 'All of the above'],
          correctAnswer: 'All of the above',
          difficulty: ChallengeDifficulty.medium,
        ),

        // 🔴 HARD (21–30)
        Challenge(
          id: 'qt_021',
          question: 'Name 5 fruits in 10 seconds!',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'qt_022',
          question: 'Say the word “banana” backward without pausing.',
          correctAnswer: 'ananab',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'qt_023',
          question: 'Name something that is both a food and a color.',
          options: ['Orange', 'Peach', 'Lemon', 'All of the above'],
          correctAnswer: 'All of the above',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'qt_024',
          question: 'Say 5 Gulf cities as fast as you can.',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'qt_025',
          question: 'List 3 things that can melt.',
          options: ['Ice', 'Chocolate', 'Butter', 'All of the above'],
          correctAnswer: 'All of the above',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'qt_026',
          question:
              'If you rearrange the letters of “DORAK,” what new word can you make?',
          options: ['Road', 'Dark', 'Radko', 'None'],
          correctAnswer: 'Dark',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'qt_027',
          question: 'Say a word that rhymes with “Game.”',
          options: ['Name', 'Same', 'Flame', 'All of the above'],
          correctAnswer: 'All of the above',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'qt_028',
          question: 'Name 3 things you’d take to the beach.',
          options: ['Towel', 'Sunscreen', 'Water', 'All of the above'],
          correctAnswer: 'All of the above',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'qt_029',
          question:
              'Say your birth month and the name of an animal that starts with the same letter.',
          difficulty: ChallengeDifficulty.hard,
        ),
        Challenge(
          id: 'qt_030',
          question: 'Spell the word “challenge” correctly — but fast!',
          correctAnswer: 'challenge',
          difficulty: ChallengeDifficulty.hard,
        ),
      ],
    };
