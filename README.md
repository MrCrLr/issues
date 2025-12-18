# Issues

**Issues** is a small command-line tool written in Elixir that fetches and displays GitHub issues for a given repository in a formatted table.

This project was built as a **practice exercise** based on *Programming Elixir* by **Dave Thomas** (Pragmatic Programmers), and extended beyond the book example to explore:

- HTTP requests with `Req`
- JSON decoding and data shaping
- CLI argument parsing
- Table formatting and truncation
- Logging and compile-time log purging
- Test refactoring and contract-based testing

---

## Features

- Fetch issues from the GitHub REST API
- Supports **open and closed issues**
- Sorts issues by creation date
- Limits output to a configurable number of issues
- Displays results in a readable ASCII table
- Truncates long fields to keep output tidy
- Uses structured logging (`Logger`) with compile-time purge configuration

---

## Usage

Build the escript:

```bash
mix escript.build
```

Run it:

```bash
./issues <github_user> <repo> [count]
```

Example:

```bash
./issues mrcrlr kracker_barrel 10
```

This will fetch issues from the repository and print the most recent ones in a table.

---

## Installation

This project is **not intended for Hex publication** — it’s a learning exercise.

If you want to use it locally as a dependency (for experimentation), you can reference it via a path dependency:

```elixir
def deps do
  [
    {:issues, path: "../issues"}
  ]
end
```

---

## Development Notes

- GitHub API base URL is configurable via application config
- Logging is configured using `compile_time_purge_matching` to remove debug logs at compile time
- Tests focus on **behavior and structure**, not brittle formatting details
- The formatter is intentionally lossy (presentation-oriented), favoring readability over completeness

---

## Documentation

Generate local documentation with:

```bash
mix docs
```

This uses **ExDoc** and outputs HTML and EPUB documentation under the `doc/` directory.

---

## Credits

- **Dave Thomas** — *Programming Elixir*
- **The Pragmatic Programmers** — https://pragprog.com
- GitHub REST API — https://docs.github.com/en/rest

---

## License

This project is for **educational purposes** only.
