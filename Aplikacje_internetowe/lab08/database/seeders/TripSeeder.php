<?php

namespace Database\Seeders;

use App\Models\Trip;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class TripSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Trip::truncate();
        Trip::insert(
            [
                [
                    'name' => 'Kolorado', 'continent' => 'Ameryka Północna', 'period' => '7',
                    'description' => 'jest wyżynno-górzystym stanem, którego średnia wysokość nad poziomem morza przekracza 2000 m. Najwyższy szczyt Kolorado, Mount Elbert, wznosi się na 4399 m n.p.m.',
                    'price' => '19000', 'img' => 'colorado.jpg', 'country_id' => '1',
                ],
                [
                    'name' => 'Alaska', 'continent' => 'Ameryka Północna', 'period' => '10',
                    'description' => 'pasmo górskie w Ameryce Północnej w stanie Alaska. Jest to najwyższa część łańcucha Kordylierów z najwyższym szczytem kontynentu - Denali (McKinley) (6194 m n.p.m.).',
                    'price' => '24000', 'img' => 'alaska.jpg',  'country_id' => '1',
                ],
                [
                    'name' => 'Everest', 'continent' => 'Azja', 'period' => '7',
                    'description' => 'najwyższy szczyt Ziemi (8848 m n.p.m., podaje się też wysokość 8844 (pomiary chińskie) lub 8850 (pomiary amerykańskie)), ośmiotysięcznik położony w Himalajach Wysokich, na granicy Nepalu i Tybetu.',
                    'price' => '22000', 'img' => 'everest.jpg',  'country_id' => '2',
                ],
                [
                    'name' => 'Alpy', 'continent' => 'Europa', 'period' => '6',
                    'description' => 'najwyższy łańcuch górski Europy, ciągnący się łukiem od wybrzeża Morza Śródziemnego w okolicy Savony po dolinę Dunaju w okolicach Wiednia.',
                    'price' => '16000', 'img' => 'alps.jpg',  'country_id' => '3',
                ],
                [
                    'name' => 'Kilimandżaro', 'continent' => 'Afryka', 'period' => '10',
                    'description' => 'góra w Tanzanii, leżąca przy granicy z Kenią. Jest najwyższą górą Afryki i jedynym miejscem na kontynencie, gdzie śnieg jest całoroczny. ',
                    'price' => '25000', 'img' => 'kilimanjaro.jpg',  'country_id' => '4',
                ],
                [
                    'name' => 'Tatry', 'continent' => 'Europa', 'period' => '5',
                    'description' => 'najwyższe pasmo w łańcuchu Karpat, również najwyższe między Alpami a Uralem i Kaukazem. Są częścią Łańcucha Tatrzańskiego, w Centralnych Karpatach Zachodnich.',
                    'price' => '7500', 'img' => 'tatry.jpg', 'country_id' => '5',
                ],
                [
                    'name' => 'Sudety', 'continent' => 'Europa', 'period' => '5',
                    'description' => 'łańcuch górski na obszarze południowo-zachodniej Polski i północnych Czech, stosunkowo niewielki skrawek znajduje się w Niemczech; najwyższy szczyt Śnieżka - 1603 m n.p.m.',
                    'price' => '8000', 'img' => 'sudety.jpg', 'country_id' => '5',
                ],
            ]
        );
    }
}
