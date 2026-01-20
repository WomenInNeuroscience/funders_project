import plotly.graph_objects as go
import dash
from dash import dcc, html
from dash.dependencies import Input, Output

# --- Setup ---
app = dash.Dash(__name__)
app.title = "WIN Repo: Transparency Reporting Scale Calculator"

# --- Define Criteria Labels and Categories ---
criteria_categories = {
    "Accessibility and FAIR principles": {
        'findable': "Findable",
        'data_downloadable': "Downloadable",
        'tabular': "Tabular format",
        'english_data': "English"
    },
    "Gender/DEI and demographics": {
        'gender': "Gender",
        'age_or_career_stage': "Age or career stage",
        'parental_leave': "Parental leave",
        'dei_eo_page': "DEI page"
    },
    "Temporal information": {
        'year_of_award': "Year of award",
        'grant_duration': "Grant duration",
        '>=3 years data': "Longitudinal"
    },
    "Funding": {
        'summary_funding': "Summary funding",
        'per_group_funding': "Individual funding",
        'report_all_applicants': "All applicants (not just winners)"
    },
    "Field": {
        'neuro_specific': "Neuro-specific"
    }
}

# --- Helper to sanitize IDs ---
def sanitize_id(s):
    return s.lower().replace(' ', '_').replace('/', '_').replace('&','and')

# --- Layout ---
app.layout = html.Div(style={'fontFamily': 'Arial', 'padding': '30px'}, children=[
    html.H2("WIN Repo: Transparency Reporting Scale Calculator", style={'textAlign': 'center'}),

    html.Div([
        html.Div([
            html.H4(category),
            dcc.Checklist(
                id=sanitize_id(category) + "_checklist",
                options=[{'label': label, 'value': key} for key, label in criteria.items()],
                value=[],
                labelStyle={'display': 'block'}
            ),
            html.Br()
        ]) for category, criteria in criteria_categories.items()
    ], style={'width': '45%', 'display': 'inline-block', 'verticalAlign': 'top'}),

    html.Div([
        html.H4("Summary"),
        html.Div(id='score-output', style={'fontSize': '20px', 'marginBottom': '20px'}),
        html.Div(id='to-improve', style={'fontSize': '16px', 'color': '#8e44ad'}),
        dcc.Graph(id='score-visual')
    ], style={'width': '50%', 'display': 'inline-block', 'paddingLeft': '30px'})
])

# --- Callback ---
inputs = [Input(sanitize_id(category) + "_checklist", 'value') for category in criteria_categories.keys()]

@app.callback(
    [Output('score-output', 'children'),
     Output('to-improve', 'children'),
     Output('score-visual', 'figure')],
    inputs
)

def update_score(access, gender_demo, temporal, fund_trans, domain):
    # Calculate score
    score = len(access) + len(gender_demo) + len(temporal) + len(fund_trans) + len(domain)

    # Determine rating
    if 13 <= score <= 15:
        rating = "Gold"
        emoji = "🥇"
        color = "gold"
    elif 9 <= score <= 12:
        rating = "Silver"
        emoji = "🥈"
        color = "silver"
    elif 1 <= score <= 8:
        rating = "Bronze"
        emoji = "🥉"
        color = "peru"
    else:
        rating = "No rating"
        emoji = "⚪"
        color = "lightgrey"

    summary_text = f"Total Score: {score}/15 → {emoji} {rating} Rating"

    # Identify missing items
    checked = set(access + gender_demo + temporal + fund_trans + domain)
    missing_items = []
    for category, items in criteria_categories.items():
        for key, label in items.items():
            if key not in checked:
                missing_items.append(f"❌ {label}")

    missing_text = "To improve:\n" + "\n".join(missing_items) if missing_items else "✔️ All criteria met!"

    # Stacked chart
    fig = go.Figure()
    fig.add_trace(go.Bar(x=["Transparency Score"], y=[len(access)], 
                        name='Accessibility and FAIR principles', marker_color='skyblue'))

    fig.add_trace(go.Bar(x=["Transparency Score"], y=[len(gender_demo)], 
                        name='Gender/DEI and demographics', marker_color='lightgreen'))

    fig.add_trace(go.Bar(x=["Transparency Score"], y=[len(temporal)], 
                        name='Temporal information', marker_color='orange'))

    fig.add_trace(go.Bar(x=["Transparency Score"], y=[len(fund_trans)], 
                        name='Funding', marker_color='salmon'))

    fig.add_trace(go.Bar(x=["Transparency Score"], y=[len(domain)], 
                        name='Field', marker_color='violet'))

    fig.update_layout(
        barmode='stack',
        height=400,
        title="Score Breakdown by Category",
        yaxis=dict(range=[0, 15], title='Points'),
        xaxis=dict(showticklabels=False)
    )

    return summary_text, missing_text, fig

# --- expose server for Render ---
server = app.server

