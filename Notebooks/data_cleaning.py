import numpy as np
import pandas as pd

#--------------------------------------------------------------------------
#PLAYER DATA
#--------------------------------------------------------------------------

players = pd.read_csv("C:/Users/ricar/OneDrive/Desktop/Python Projects/MLB2025Season/Data/Raw/players_2025.csv")

#inspecting data
###print("checking for null values")
###players.head()
###players.info()
###players.isnull().sum()
###print("How many duplicate values?")
###print(players.duplicated().sum())
###print("column names and data types:")
###print(players.columns)
###print(players.dtypes)
###print(players.head())
###print(players.shape)

# Create batting dataframe
batting = players[players["age_hit"].notna()].copy()

# Create pitching dataframe
batting_columns = [

    "player_id",
    "player_name",
    "team_id",
    "team_name",
    "age_hit",
    "gamesPlayed_hit",
    "runs_hit",
    "doubles_hit",
    "triples_hit",
    "homeRuns_hit",
    "strikeOuts_hit",
    "baseOnBalls_hit",
    "hits_hit",
    "avg_hit",
    "atBats_hit",
    "obp_hit",
    "slg_hit",
    "ops_hit",
    "stolenBases_hit",
    "plateAppearances",
    "totalBases_hit",
    "rbi"
]

batting = batting[batting_columns]

#reformat columns

batting = batting.rename(columns={
    "age_hit": "age",
    "gamesPlayed_hit": "games_played",
    "runs_hit": "runs",
    "doubles_hit": "doubles",
    "triples_hit": "triples",
    "homeRuns_hit": "home_runs",
    "strikeOuts_hit": "strikeouts",
    "baseOnBalls_hit": "walks",
    "hits_hit": "hits",
    "avg_hit": "batting_average",
    "atBats_hit": "at_bats",
    "obp_hit": "obp",
    "slg_hit": "slg",
    "ops_hit": "ops",
    "stolenBases_hit": "stolen_bases",
    "plateAppearances": "plate_appearances",
    "totalBases_hit": "total_bases"
})

#dropping floats for numbers that we dont need as floats

integer_columns = [
    "age",
    "games_played",
    "runs",
    "doubles",
    "triples",
    "home_runs",
    "strikeouts",
    "walks",
    "hits",
    "at_bats",
    "stolen_bases",
    "plate_appearances",
    "total_bases",
    "rbi"
]

batting[integer_columns] = batting[integer_columns].astype(int)


batting.to_csv("C:/Users/ricar/OneDrive/Desktop/Python Projects/MLB2025Season/Data/Clean/batting_2025_cleaned.csv", index=False)

#pitching data 

pitching = pd.read_csv(
    "C:/Users/ricar/OneDrive/Desktop/Python Projects/MLB2025Season/Data/Raw/FantasyPros_2025_Pitchers_Stats.csv"
)

pitching = pitching.dropna()

pitching = pitching.rename(columns={
    "Player": "player_name",
    "IP": "innings_pitched",
    "K": "strikeouts",
    "W": "wins",
    "QS": "quality_starts",
    "SV": "saves",
    "ERA": "era",
    "WHIP": "whip",
    "ER": "earned_runs",
    "H": "hits_allowed",
    "BB": "walks",
    "HR": "home_runs_allowed",
    "G": "games_played",
    "GS": "games_started",
    "L": "losses",
    "CG": "complete_games",
    "Rost%": "roster_percentage"
})
pitching["player_name"] = pitching["player_name"].str.split("(").str[0].str.strip()

pitching = pitching.drop(columns=["VBR"])
integer_columns = [
    "strikeouts",
    "wins",
    "quality_starts",
    "saves",
    "earned_runs",
    "hits_allowed",
    "walks",
    "home_runs_allowed",
    "games_played",
    "games_started",
    "losses",
    "complete_games"
]

pitching = pitching.drop(columns=["roster_percentage"])
pitching[integer_columns] = pitching[integer_columns].astype(int)
pitching.to_csv(
    "C:/Users/ricar/OneDrive/Desktop/Python Projects/MLB2025Season/Data/Clean/pitching_2025_cleaned.csv",
    index=False
)


#--------------------------------------------------------------------------
#TEAM DATA
#--------------------------------------------------------------------------

teams = pd.read_csv(
    "C:/Users/ricar/OneDrive/Desktop/Python Projects/MLB2025Season/Data/Raw/teams_2025_combined.csv"
)

##print(teams.head())
##print(teams.info())
##print(teams.duplicated().sum())
##print(teams.info())
##print(teams.isnull().sum())
##print(teams.columns)
##print("Shape:", teams.shape)
team_columns = [    
    "team_id",
    "team_name",
    "league",
    "division",
    "hit_gamesPlayed",
    "hit_runs",
    "hit_doubles",
    "hit_triples",
    "hit_homeRuns",
    "hit_baseOnBalls",
    "hit_strikeOuts",
    "hit_hits",
    "hit_avg",
    "hit_obp",
    "hit_slg",
    "hit_ops",
    "hit_stolenBases"
]

teams = teams[team_columns]


teams = teams.rename(columns={
    "hit_gamesPlayed": "games_played",
    "hit_runs": "runs",
    "hit_doubles": "doubles",
    "hit_triples": "triples",
    "hit_homeRuns": "home_runs",
    "hit_baseOnBalls": "walks",
    "hit_strikeOuts": "strikeouts",
    "hit_hits": "hits",
    "hit_avg": "batting_average",
    "hit_obp": "obp",
    "hit_slg": "slg",
    "hit_ops": "ops",
    "hit_stolenBases": "stolen_bases"
})


teams.to_csv(
    "C:/Users/ricar/OneDrive/Desktop/Python Projects/MLB2025Season/Data/Clean/teams_2025_cleaned.csv",
    index=False
)

