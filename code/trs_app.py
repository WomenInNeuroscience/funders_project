import plotly.graph_objects as go
import dash
from dash import dcc, html
from dash.dependencies import Input, Output

# --- Setup ---
app = dash.Dash(__name__)
app.title = "WIN Repo: Transparency Reporting Scale Calculator"

# --- Define Criteria Labels and Categories ---
criteria_categories = {
    "Data Availability": {
        'findable': "Findable (publicly available data)",
        'downloadable': "Downloadable (improves prosperity and enables analysis)",
        'tabular': "Tabular format (spreadsheet/table)",
        'all_applicants': "All applicants’ reported (not just awardees)",
        'longitudinal': "Longitudinal (3+ years)"
    },
    "Equity Dimensions": {
        'gender': "Gender reported",
        'age': "Age or career Stage",
        'dei_page': "DEI policy page",
        'parental_leave': "Parental leave policy available"
    },
    "Funding Transparency": {
        'summary_funding': "Summary funding amounts",
        'per_group_funding': "Per-awardee funding amounts",
        'year_of_award': "Year of award reported",
        'grant_duration': "Grant duration",
        'english': "Provided in English",
        'neuro_specific': "Neuroscience-specific funding"
    }
}

# --- Layout ---
app.layout = html.Div(style={'fontFamily': 'Arial', 'padding': '30px'}, children=[
    html.H2("WIN Repo: Transparency Assessment Tool", style={'textAlign': 'center'}),

    html.Div([
        html.Div([
            html.H4(category),
            dcc.Checklist(
                id=f"{category.lower().replace(' ','_')}_checklist",
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
@app.callback(
    [Output('score-output', 'children'),
     Output('to-improve', 'children'),
     Output('score-visual', 'figure')],
    [Input('data_availability_checklist', 'value'),
     Input('equity_dimensions_checklist', 'value'),
     Input('funding_transparency_checklist', 'value')]
)
def update_score(data_av, equity, fund_trans):
    # Calculate score
    score = len(data_av) + len(equity) + len(fund_trans)

    # Determine rating
    if score >= 13:
        rating = "Gold"
        emoji = "🥇"
        color = "gold"
    elif score >= 9:
        rating = "Silver"
        emoji = "🥈"
        color = "silver"
    elif score >= 1:
        rating = "Bronze"
        emoji = "🥉"
        color = "peru"
    else:
        rating = "No"
        emoji = "⚪"
        color = "lightgrey"

    summary_text = f"Total Score: {score}/15 → {emoji} {rating} Rating"

    # Identify missing items
    checked = set(data_av + equity + fund_trans)
    missing_items = []
    for category, items in criteria_categories.items():
        for key, label in items.items():
            if key not in checked:
                missing_items.append(f"❌ {label}")

    missing_text = "To improve:\n" + "\n".join(missing_items) if missing_items else "✔️ All criteria met!"

    # Stacked chart
    fig = go.Figure()
    fig.add_trace(go.Bar(
        x=["Transparency Score"], y=[len(data_av)],
        name='Data Availability',
        marker_color=color  # use rating color
    ))
    fig.add_trace(go.Bar(
        x=["Transparency Score"], y=[len(equity)],
        name='Equity Dimensions',
        marker_color=color
    ))
    fig.add_trace(go.Bar(
        x=["Transparency Score"], y=[len(fund_trans)],
        name='Funding Transparency',
        marker_color=color
    ))
    """
    fig = go.Figure()
    fig.add_trace(go.Bar(x=["Transparency Score"], y=[len(data_av)], name='Data Availability', marker_color='lightgreen'))
    fig.add_trace(go.Bar(x=["Transparency Score"], y=[len(equity)], name='Equity Dimensions', marker_color='lightskyblue'))
    fig.add_trace(go.Bar(x=["Transparency Score"], y=[len(fund_trans)], name='Funding Transparency', marker_color='orchid'))
    """
    fig.update_layout(
        barmode='stack',
        height=400,
        title="Score Breakdown by Category",
        yaxis=dict(range=[0, 15], title='Points'),
        xaxis=dict(showticklabels=False)
    )

    return summary_text, missing_text, fig

# --- Run ---
if __name__ == '__main__':
    app.run(debug=True)

